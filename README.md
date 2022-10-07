# Country_Search
We have a list of cities containing around 200k entries in JSON format. Each entry contains the following information:
- Load the list of cities from https://raw.githubusercontent.com/SiriusiOS/ios-assignment/main/cities.json.
- Be able to filter the results by a given prefix string, following these requirements:
- Follow the prefix definition specified in the clarifications section below.
- Implement a search algorithm optimised for fast runtime searches. Initial loading time of the app does not matter.
- Search is case insensitive.
- Display these cities in a scrollable list, in alphabetical order (city first, country after). Hence, "Denver, US" should appear before "Sydney, Australia".
- The list should be updated with every character added/removed to/from the filter.
- Each city's cell should:
-- Show the city and country code as title.
-- Show the coordinates as subtitle.
-- When tapped, show the location of that city on a map.

## Version

1.0

## Build and Runtime Requirements
+ Xcode 12 or later
+ iOS 9.0 or later
+ Cocoapods

## Run the following commands
- Make sure you are added to relevant account organisation and team: Github and Apple
- Open Terminal Apps and run following commands:
- git clone git@github.com:ThinzarThinzarSoe/Country_Search.git to clone the project (make sure your machine installed git)
- git pull origin main to pull latest sourcecodes
- pod install to install related libraries
- open Code_test.xcworkspace and run the project

## Screenshots

<div>
    <img src="/Screenshot/Img-CountryList.png" width="200px" height="400px"  ></img>
    <img src="/Screenshot/Img-MapView.png" width="200px" height="400px"  ></img>
</div>

## Technologies

Country Search iOS use the following architecture and technologies

- MVVM Design Pattern
- RxSwift
- RxCocoa
- SnapKit
- Cocoapods

Why I use RxSwift?

Apple's iOS supports both synchronous and asynchronous tasks. In synchronous operations, tasks are performed one at a time. Therefore, other tasks must wait until the previous task is completed before continuing. Asynchronous tasks run simultaneously in the background. If background tasks are completed, we will be notified. Asynchronous programming allows our to process multiple requests at the same time, so we can accomplish more tasks in a shorter amount of time.Async work can be handled using third-party libraries. A few notable examples are Promises (PromiseKit), RxSwift, and ReactiveCocoa.

## Search Methods

In this project , I use presfix search tree (Trie Search Algorithm)

I lerned from , https://www.raywenderlich.com/892-swift-algorithm-club-swift-trie-data-structure

To add city name in node

    mutating func add(_ city: CityVO) {
        guard !(city.name?.isEmpty ?? true) else { return }
        var currentNode = root
        for character in (city.name ?? "").lowercased() {
            if let childNode = currentNode.children[character] {
                currentNode = childNode
            } else {
                currentNode = currentNode.add(child: character)
            }
        }
        guard !currentNode.isTerminating else {
            return
        }
        if var exisitingCities = cityList[(city.name ?? "").lowercased()] {
            exisitingCities.append(city)
            cityList[(city.name ?? "").lowercased()] = exisitingCities
        } else {
            cityList[(city.name ?? "").lowercased()] = [city]
        }
        cityCount += 1
        currentNode.isTerminating = true
    }
    
To search list of city by using search keywords

    func findCitiesWithPrefix(prefix: String) -> [CityVO] {
        var words = [String]()
        var cities = [CityVO]()
        let prefixLowerCased = prefix.lowercased()
        if let lastNode = findLastNodeOf(word: prefixLowerCased) {
            if lastNode.isTerminating {
                words.append(prefixLowerCased)
            }
            for childNode in lastNode.children.values {
                let childWords = wordsInSubtrie(rootNode: childNode, partialWord: prefixLowerCased)
                words += childWords
            }
        }
        words.forEach { word in
            guard let data = cityList[word.lowercased()]?[0] else {return}
            cities.append(data)
        }
        return cities
    }
    
We should learned advantages and disadvantages of Trie.

#### Advantages of Trie data structure:

- Trie allows us to input and finds strings in O(l) time, where l is the length of a single word. It is faster as compared to both hash tables and binary search trees.

- It provides alphabetical filtering of entries by the key of the node and hence makes it easier to print all words in alphabetical order.

- Trie takes less space when compared to BST because the keys are not explicitly saved instead each key requires just an amortized fixed amount of space to be stored.

- Prefix search/Longest prefix matching can be efficiently done with the help of trie data structure.

- Since trie doesn’t need any hash function for its implementation so they are generally faster than hash tables for small keys like integers and pointers.

- Tries support ordered iteration whereas iteration in a hash table will result in pseudorandom order given by the hash function which is usually more cumbersome

#### Disadvantages of Trie data structure:

- The main disadvantage of the trie is that it takes a lot of memory to store all the strings. For each node, we have too many node pointers which are equal to the no of characters in the worst case.

## Contributing

- If you found a bug, open an issue.

- If you have a feature request, open an issue.

- If you want to contribute , submit a pull request.

## Contact

- thinzarsoe76@gmail.com

//
//  CityTrie.swift
//  Code_Test
//
//  Created by Thinzar Soe on 10/7/22.
//

import Foundation

struct CityTrie {
    typealias Node = TrieNode<Character>
    
    public var count: Int {
        return wordCount
    }
    
    public var isEmpty: Bool {
        return wordCount == 0
    }
    
    fileprivate let root: Node
    fileprivate var wordCount: Int
    var wordCitiesMap: [String: [CountryVO]] = [String: [CountryVO]]()
    
    public init() {
        root = Node()
        wordCount = 0
    }
}

extension CityTrie {
    mutating func add(_ city: CountryVO) {
        guard !(city.name?.isEmpty ?? true) || !(city.country?.isEmpty ?? true) else { return }
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
        if var exisitingCities = wordCitiesMap[(city.name ?? "").lowercased()] {
            exisitingCities.append(city)
            wordCitiesMap[(city.name ?? "").lowercased()] = exisitingCities
        } else {
            wordCitiesMap[(city.name ?? "").lowercased()] = [city]
        }
        wordCount += 1
        currentNode.isTerminating = true
    }
    
    func findCitiesWithPrefix(prefix: String) -> [CountryVO] {
        var words = [String]()
        var cityList = [CountryVO]()
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
            guard let data = wordCitiesMap[word.lowercased()]?[0] else {return}
            cityList.append(data)
        }
        return cityList
    }

    func findLastNodeOf(word: String) -> Node? {
        var currentNode = root
        for character in word.lowercased() {
            guard let childNode = currentNode.children[character] else {
                return nil
            }
            currentNode = childNode
        }
        return currentNode
    }
    
    fileprivate func wordsInSubtrie(rootNode: Node, partialWord: String) -> [String] {
        var subtrieWords = [String]()
        var previousLetters = partialWord
        if let value = rootNode.value {
            previousLetters.append(value)
        }
        if rootNode.isTerminating {
            subtrieWords.append(previousLetters)
        }
        for childNode in rootNode.children.values {
            let childWords = wordsInSubtrie(rootNode: childNode, partialWord: previousLetters)
            subtrieWords += childWords
        }
        return subtrieWords
    }
}


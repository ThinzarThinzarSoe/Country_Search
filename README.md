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

## Technologies

Country Search iOS use the following architecture and technologies

- MVVM Design Pattern
- RxSwift
- RxCocoa
- SnapKit
- Cocoapods

Why I use RxSwift?

Apple's iOS supports both synchronous and asynchronous tasks. In synchronous operations, tasks are performed one at a time. Therefore, other tasks must wait until the previous task is completed before continuing. Asynchronous tasks run simultaneously in the background. If background tasks are completed, we will be notified. Asynchronous programming allows our to process multiple requests at the same time, so we can accomplish more tasks in a shorter amount of time.Async work can be handled using third-party libraries. A few notable examples are Promises (PromiseKit), RxSwift, and ReactiveCocoa.

## Contributing

- If you found a bug, open an issue.

- If you have a feature request, open an issue.

- If you want to contribute , submit a pull request.

## Contact

- thinzarsoe76@gmail.com

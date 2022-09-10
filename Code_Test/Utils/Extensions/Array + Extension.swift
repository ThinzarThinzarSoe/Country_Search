//
//  Array + Extension.swift
//  Code_Test
//
//  Created by Thinzar Soe on 9/10/22.
//


import Foundation

extension Array{

/* Array Must be sorted */

    
    func binarySearch(key: String) -> [Index]? {
        return self.binarySearch(key: key, initialIndex: 0)
    }

    private func binarySearch(key: String, initialIndex: Index) -> [Index]? {
        let countryList = self as! [CountryResponse]
        guard countryList.count > 0 else { return nil }
        let midIndex = countryList.count / 2
        let midElement = countryList[midIndex]
        var indexes : [Index] = []
        
        if midElement.name?.caseInsensitiveHasPrefix(key) ?? true || midElement.country?.caseInsensitiveHasPrefix(key) ?? true {

            // Found!

            let foundIndex = initialIndex + midIndex

            indexes = [foundIndex]

            // Check neighbors for same values

            // Check Left Side

            var leftIndex = midIndex - 1

            while leftIndex >= 0 {

                //While there is still more items on the left to check
                let newString = countryList[leftIndex]

                if newString.name?.caseInsensitiveHasPrefix(key) ?? true || newString.country?.caseInsensitiveHasPrefix(key) ?? true {

                    //If the items on the left is still matching key

                    indexes.append(leftIndex + initialIndex)

                    leftIndex -= 1

                } else {

                    // The item on the left is not identical to key

                    break
                }
            }

            // Check Right side

            var rightIndex = midIndex + 1

            while rightIndex < countryList.count {

                //While there is still more items on the left to check
                let newString = countryList[rightIndex]

                if newString.name?.caseInsensitiveHasPrefix(key) ?? true || newString.country?.caseInsensitiveHasPrefix(key) ?? true {

                    //If the items on the left is still matching key

                    indexes.append(rightIndex + initialIndex)

                    rightIndex += 1

                } else {
                    rightIndex += 1
                }
            }

            return indexes.sorted{ return $0 < $1 }
        }
        

        if countryList.count == 1 {

            guard let first = countryList.first else { return nil }

            if first.name?.caseInsensitiveHasPrefix(key) ?? true || first.country?.caseInsensitiveHasPrefix(key) ?? true {
                return [initialIndex]
            }
            return nil
        }

        if key < midElement.name ?? "" || key < midElement.country ?? "" {

            return Array(self[0..<midIndex]).binarySearch(key: key, initialIndex: initialIndex + 0)
        }

        if key > midElement.name ?? "" || key > midElement.country ?? "" {

            return Array(self[midIndex..<countryList.count]).binarySearch(key: key, initialIndex: initialIndex + midIndex)
        }

        return nil
    }
}



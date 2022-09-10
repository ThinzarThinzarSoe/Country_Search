//
//  Code_TestTests.swift
//  Code_TestTests
//
//  Created by Thinzar Soe on 9/5/22.
//

import XCTest
import RxSwift

@testable import Code_Test

class Code_TestTests: XCTestCase {
    var countryList : [CountryResponse] = []
    
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func getCountryList() {
        if let path = Bundle.main.path(forResource: "cities-Test", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                countryList = data.decode(modelType: [CountryResponse].self) ?? []
            } catch {
                // handle error
            }
        }
    }
    
    func testSearchFunction() {
        getCountryList()
        let list = self.countryList.sorted { $0.name ?? "" < $1.name ?? ""}
        let indexList = list.binarySearch(key: "A" )
        var searchedCountryList : [CountryResponse] = []
        indexList?.sorted().forEach({ index in
            searchedCountryList.append(list[index])
        })
        XCTAssertEqual(searchedCountryList.count, 4)
    }
}

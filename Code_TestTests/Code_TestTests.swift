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
    var countryList : [CityVO] = []
    var trie = CityTrie()
    
    override func setUp() {
        super.setUp()
        getCountryList()
    }

    override func tearDown() {
        super.tearDown()
    }

    func getCountryList() {
        if let path = Bundle.main.path(forResource: "cities-Test", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                countryList = data.decode(modelType: [CityVO].self) ?? []
                countryList.forEach({ city in
                    self.trie.add(city)
                })
            } catch {
                // handle error
            }
        }
    }
    
    func testSearchFunctionForPass() {
        let searchedCountryList = self.trie.findCitiesWithPrefix(prefix: "A").sorted{ $0.name ?? ""  < $1.name ?? ""}
        let expectedArray : [CityVO] = [
                            CityVO(country: "US", name: "Alabama", _id: 4829764 , coord: CoordinateVO(lon: -86.750259, lat:32.750408 )),
                            CityVO(country: "US", name: "Albuquerque", _id: 5454711 , coord: CoordinateVO(lon:-106.651138 , lat:35.084492 )),
                            CityVO(country: "US", name: "Anaheim", _id: 5323810 , coord: CoordinateVO(lon: -117.914497, lat: 33.835289)),
                            CityVO(country: "HN", name: "Arizona", _id:3615069 , coord: CoordinateVO(lon: -87.316673, lat: 15.63333))
                            ]
        print(searchedCountryList)
        XCTAssertEqual(expectedArray[0]._id, searchedCountryList[0]._id)
        XCTAssertEqual(expectedArray[1]._id, searchedCountryList[1]._id)
        XCTAssertEqual(expectedArray[2]._id, searchedCountryList[2]._id)
        XCTAssertEqual(expectedArray[3]._id, searchedCountryList[3]._id)
    }
    
    func testSearchFunctionForFail() {
        let searchedCountryList = self.trie.findCitiesWithPrefix(prefix: "YYY")
        XCTAssertEqual(searchedCountryList.count, 0)
    }
}

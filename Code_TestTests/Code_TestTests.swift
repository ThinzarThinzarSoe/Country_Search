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
        getCountryList()
    }

    override func tearDown() {
        super.tearDown()
    }

    func getCountryList() {
        if let path = Bundle.main.path(forResource: "cities-Test", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let list = data.decode(modelType: [CountryResponse].self) ?? []
                self.countryList = list.sorted { $0.name ?? "" < $1.name ?? ""}
            } catch {
                // handle error
            }
        }
    }
    
    func testSearchFunction() {
        let indexList = countryList.binarySearch(key: "U" )
        let expectedArray : [CountryResponse] = [
                            CountryResponse(country: "US", name: "Alabama", _id: 4829764 , coord: CoordinateVO(lon: -86.750259, lat:32.750408 )),
                            CountryResponse(country: "US", name: "Albuquerque", _id: 5454711 , coord: CoordinateVO(lon:-106.651138 , lat:35.084492 )),
                            CountryResponse(country: "US", name: "Anaheim", _id: 5323810 , coord: CoordinateVO(lon: -117.914497, lat: 33.835289)),
                            CountryResponse(country: "US", name: "Hampden Sydney", _id:4762888 , coord: CoordinateVO(lon: -78.459717, lat: 37.242371)),
                            CountryResponse(country: "HN", name: "Urizona", _id: 3615069 , coord: CoordinateVO(lon: -87.316673, lat: 15.63333))
                            ]
        var searchedCountryList : [CountryResponse] = []
        indexList?.sorted().forEach({ index in
            searchedCountryList.append(countryList[index])
        })
        XCTAssertEqual(expectedArray[0]._id, searchedCountryList[0]._id)
        XCTAssertEqual(expectedArray[1]._id, searchedCountryList[1]._id)
        XCTAssertEqual(expectedArray[2]._id, searchedCountryList[2]._id)
        XCTAssertEqual(expectedArray[3]._id, searchedCountryList[3]._id)
        XCTAssertEqual(expectedArray[4]._id, searchedCountryList[4]._id)
    }
    
    func testSearchFunctionForPass() {
        let indexList = countryList.binarySearch(key: "A" )
        let expectedArray : [CountryResponse] = [
                            CountryResponse(country: "US", name: "Alabama", _id: 4829764 , coord: CoordinateVO(lon: -86.750259, lat:32.750408 )),
                            CountryResponse(country: "US", name: "Albuquerque", _id: 5454711 , coord: CoordinateVO(lon:-106.651138 , lat:35.084492 )),
                            CountryResponse(country: "US", name: "Anaheim", _id: 5323810 , coord: CoordinateVO(lon: -117.914497, lat: 33.835289)),
                            CountryResponse(country: "HN", name: "Arizona", _id:3615069 , coord: CoordinateVO(lon: -87.316673, lat: 15.63333))
                            ]
        var searchedCountryList : [CountryResponse] = []
        indexList?.sorted().forEach({ index in
            searchedCountryList.append(countryList[index])
        })
        XCTAssertEqual(expectedArray[0]._id, searchedCountryList[0]._id)
        XCTAssertEqual(expectedArray[1]._id, searchedCountryList[1]._id)
        XCTAssertEqual(expectedArray[2]._id, searchedCountryList[2]._id)
        XCTAssertEqual(expectedArray[3]._id, searchedCountryList[3]._id)
    }
    
    func testSearchFunctionForFail() {
        let indexList = countryList.binarySearch(key: "YYYYY" )
        var searchedCountryList : [CountryResponse] = []
        indexList?.sorted().forEach({ index in
            searchedCountryList.append(countryList[index])
        })
        XCTAssertEqual(searchedCountryList.count, 0)
    }
}

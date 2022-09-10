//
//  ApiConfig.swift
//  Code_Test
//
//  Created by Thinzar Soe on 9/8/22.
//

import Foundation

struct ApiConfig {
    
#if DEBUG
    static private let url = "https://raw.githubusercontent.com/SiriusiOS/ios-assignment"
    
#else
    static private let url = "https://raw.githubusercontent.com/SiriusiOS/ios-assignment"
    
#endif
    
    static let NullState = "null"
    static let successCodeRange = 200...300
    
    static var baseUrl: String {
        return  url
    }
    
    enum CountryList: String {
        case getCountryList = "/main/cities.json"
        
        func getURLString() -> String {
            return ApiConfig.baseUrl + rawValue
        }
    }
}

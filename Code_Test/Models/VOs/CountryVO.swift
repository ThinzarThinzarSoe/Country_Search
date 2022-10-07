//
//  CountryResponse.swift
//  Code_Test
//
//  Created by Thinzar Soe on 9/8/22.
//

import Foundation

struct CountryVO : Codable {
    var country : String?
    var name : String?
    var _id : Int?
    var coord : CoordinateVO?
    
}

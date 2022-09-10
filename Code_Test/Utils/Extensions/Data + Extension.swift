//
//  Data + Extension.swift
//  Code_Test
//
//  Created by Thinzar Soe on 9/9/22.
//

import Foundation


extension Data {
        
    func decode<T>(modelType: T.Type,
                   success : @escaping (T) -> Void,
                   failure : @escaping (String) -> Void) where T : Decodable{
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let result = try decoder.decode(modelType, from: self)
            success(result)
        } catch let jsonError{
            print("an error occur while decoding . . . \(jsonError) >>>>> \(modelType)")
            failure(jsonError.localizedDescription)
        }
    }
    
    func decode<T>(modelType: T.Type) -> T? where T : Decodable{
        let decoder = JSONDecoder()
        do {
            let result = try decoder.decode(modelType, from: self)
            return result
        } catch let jsonError{
            print("an error occur while decoding . . . \(jsonError.localizedDescription) >>>>> \(modelType)")
            return nil
        }
    }
}


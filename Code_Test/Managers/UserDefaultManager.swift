//
//  UserDefaultManager.swift
//  Code_Test
//
//  Created by Thinzar Soe on 9/5/22.
//

//import Foundation
//
//struct UserDefaultManager {
//
//     //MARK:- Keys
//
//    enum Key : String{
//        case SAMPLE_DATA = "SAMPLE_DATA"
//        func getKey() -> String {
//            return rawValue
//        }
//    }
//
//
//    // MARK:- Setting and getting Bool in NSUserDefault
//    static func saveBoolToNSUserDefault(value: Bool, key: String) {
//        UserDefaults.standard.set(value, forKey: key)
//    }
//
//    static func retrieveBoolFromNSUserDefault(key:String) -> Bool {
//        return UserDefaults.standard.bool(forKey: key)
//    }
//
//    // MARK:- Setting and getting String in NSUserDefault
//    static func saveStringToNSUserDefault(value: String, key: String) {
//        UserDefaults.standard.set(value, forKey: key)
//    }
//
//    static func retrieveStringFromNSUserDefault(key: String) -> String {
//        return UserDefaults.standard.string(forKey: key) ?? ""
//    }
//
//    // MARK:- Setting and getting Int in NSUserDefault
//    static func saveIntToNSUserDefault(value: Int, key: String) {
//        UserDefaults.standard.set(value, forKey: key)
//    }
//
//    static func retrieveIntFromNSUserDefault(key: String) -> Int {
//        return UserDefaults.standard.integer(forKey: key)
//    }
//
//    // MARK:- Setting and getting UInt64 in NSUserDefault
//    static func saveIntToNSUserDefault(value: UInt64, key: String) {
//        UserDefaults.standard.set(value, forKey: key)
//    }
//
//    static func retrieveIntFromNSUserDefault(key: String) -> UInt64 {
//        return UInt64(UserDefaults.standard.integer(forKey: key))
//    }
//
//    // MARK:- Setting and getting Object as Data in NSUserDefault
//    static func saveObjectToNSUserDefault(value: Data, key: String) {
//        UserDefaults.standard.set(value, forKey: key)
//    }
//
//    static func retrieveObjectFromNSUserDefault(key:String) -> Data? {
//        return UserDefaults.standard.object(forKey: key) as? Data
//    }
//
//    // MARK:- Setting and getting Object as Data in NSUserDefault
//    static func saveObjectArrayToNSUserDefault(value: [Data], key: String) {
//        UserDefaults.standard.set(value, forKey: key)
//    }
//
//    static func retrieveCommomObjectArrayFromNSUserDefault(key:String) -> [Data]? {
//        return UserDefaults.standard.object(forKey: key) as? [Data]
//    }
//    // MARK:- remove
//       static func removeObj(key : String){
//           UserDefaults.standard.removeObject(forKey: key)
//       }
//}
//

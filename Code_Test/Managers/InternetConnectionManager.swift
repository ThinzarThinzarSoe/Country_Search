//
//  InternetConnectionManager.swift
//  Code_Test
//
//  Created by Thinzar Soe on 9/8/22.
//

import Foundation
import SystemConfiguration

class InternetConnectionManager {
     
    static let shared = InternetConnectionManager()
     
    func isConnectedToNetwork() -> Bool {
         
         var zeroAddress = sockaddr_in()
         zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
         zeroAddress.sin_family = sa_family_t(AF_INET)
         
         let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
             $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                 SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
             }
         }
         
         var flags = SCNetworkReachabilityFlags()
         if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
             return false
         }
         let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
         let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
         return (isReachable && !needsConnection)
     }
}


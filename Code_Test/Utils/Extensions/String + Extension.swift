//
//  String + Extension.swift
//  Code_Test
//
//  Created by Thinzar Soe on 9/9/22.
//

import Foundation

extension String {
    func caseInsensitiveHasPrefix(_ prefix: String) -> Bool {
        return range(of: prefix, options: [.anchored,.caseInsensitive]) != nil
    }
}


extension String {

  static func ==(lhs: String, rhs: String) -> Bool {
    return lhs.compare(rhs, options: .numeric) == .orderedSame
  }

  static func <(lhs: String, rhs: String) -> Bool {
    return lhs.compare(rhs, options: .numeric) == .orderedAscending
  }

  static func <=(lhs: String, rhs: String) -> Bool {
    return lhs.compare(rhs, options: .numeric) == .orderedAscending || lhs.compare(rhs, options: .numeric) == .orderedSame
  }

  static func >(lhs: String, rhs: String) -> Bool {
    return lhs.compare(rhs, options: .numeric) == .orderedDescending
  }

  static func >=(lhs: String, rhs: String) -> Bool {
    return lhs.compare(rhs, options: .numeric) == .orderedDescending || lhs.compare(rhs, options: .numeric) == .orderedSame
  }

}

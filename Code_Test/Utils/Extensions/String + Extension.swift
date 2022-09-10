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

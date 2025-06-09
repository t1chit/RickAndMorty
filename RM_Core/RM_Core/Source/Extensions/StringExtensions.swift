//
//  StringExtensions.swift
//  RM_Core
//
//  Created by Temur Chitashvili on 09.06.25.
//

import Foundation

public extension String {
    var extractedID: Int? {
        return self.split(separator: "/").last.flatMap { Int($0) }
    }
}

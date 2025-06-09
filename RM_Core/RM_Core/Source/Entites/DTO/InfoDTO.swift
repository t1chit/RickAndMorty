//
//  InfoDTO.swift
//  RM_Core
//
//  Created by Temur Chitashvili on 08.06.25.
//


import Foundation

public struct InfoDTO: Decodable {
    public let count: Int
    public let pages: Int
    public let next: String?
    public let prev: String?

    public init(
        count: Int,
        pages: Int,
        next: String?,
        prev: String?
    ) {
        self.count = count
        self.pages = pages
        self.next = next
        self.prev = prev
    }
}

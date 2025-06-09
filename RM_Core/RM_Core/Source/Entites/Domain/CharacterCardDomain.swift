//
//  CharacterCardDomain.swift
//  RM_Core
//
//  Created by Temur Chitashvili on 07.06.25.
//


import Foundation

public struct CharacterCardDomain: Decodable, Identifiable {
    public let id: Int
    public let name: String
    public let image: String
    public let gender: String
    
    public init(
        id: Int,
        name: String,
        image: String,
        gender: String
    ) {
        self.id = id
        self.name = name
        self.image = image
        self.gender = gender
    }
}

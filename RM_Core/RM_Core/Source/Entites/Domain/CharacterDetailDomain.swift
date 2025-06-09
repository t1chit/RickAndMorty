//
//  CharacterDetailDomain.swift
//  RM_Core
//
//  Created by Temur Chitashvili on 09.06.25.
//


import Foundation

public struct CharacterDetailDomain {
    public let id: Int
    public let name: String
    public let image: String
    public let gender: String
    public let species: String
    public let originName: String
    public let type: String
    public let status: String
    public let episodes: [String]
    public let locationName: String
    
    public init(
        id: Int,
        name: String,
        image: String,
        gender: String,
        species: String,
        originName: String,
        type: String,
        status: String,
        episodes: [String],
        locationName: String
    ) {
        self.id = id
        self.name = name
        self.image = image
        self.gender = gender
        self.species = species
        self.originName = originName
        self.type = type
        self.status = status
        self.episodes = episodes
        self.locationName = locationName
    }
}

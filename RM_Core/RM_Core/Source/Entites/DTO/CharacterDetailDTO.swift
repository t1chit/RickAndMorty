//
//  CharacterDetailDTO.swift
//  RM_Core
//
//  Created by Temur Chitashvili on 08.06.25.
//


import Foundation

public struct CharacterDetailDTO: Decodable, Identifiable {
    public let id: Int
    public let name: String
    public let status: String
    public let species: String
    public let type: String
    public let gender: String
    public let origin: LocationDTO
    public let location: LocationDTO
    public let image: String
    public let episode: [String]
    public let url: String
    public let created: String
    
    public init(
        id: Int,
        name: String,
        status: String,
        species: String,
        type: String,
        gender: String,
        origin: LocationDTO,
        location: LocationDTO,
        image: String,
        episode: [String],
        url: String,
        created: String
    ) {
        self.id = id
        self.name = name
        self.status = status
        self.species = species
        self.type = type
        self.gender = gender
        self.origin = origin
        self.location = location
        self.image = image
        self.episode = episode
        self.url = url
        self.created = created
    }
}


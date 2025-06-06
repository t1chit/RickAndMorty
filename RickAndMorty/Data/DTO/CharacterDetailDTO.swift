//
//  Character.swift
//  CleanRickAndMorty
//
//  Created by Temur Chitashvili on 23.05.25.
//

// Requirements:
/// Get All Characters List
/// Character Details
/// Clean + Network Reusable + Dependency Injection + MVI
///
/// Navigation Stack, Router, ViewFactory
/// Protocol Oriented

import Foundation

struct CharacterDetailDTO: Decodable, Identifiable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: LocationDTO
    let location: LocationDTO
    let image: String
    let episode: [String]
    let url: String
    let created: String
}


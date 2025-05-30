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

struct CharacterDetail: Decodable, Identifiable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: Location
    let location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

struct CharactersList: Decodable {
    let info: Info
    let results: [CharacterDetail]
}

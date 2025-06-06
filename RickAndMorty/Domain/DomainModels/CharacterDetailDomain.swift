//
//  CharacterDetailDomain.swift
//  RickAndMorty
//
//  Created by Temur Chitashvili on 06.06.25.
//

import Foundation

struct CharacterDetailDomain: Decodable, Identifiable {
    let id: Int
    let name: String
    let image: String
    let gender: String
}

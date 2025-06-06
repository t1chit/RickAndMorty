//
//  CharactersList.swift
//  RickAndMorty
//
//  Created by Temur Chitashvili on 06.06.25.
//

import Foundation

struct CharactersListDTO: Decodable {
    let info: InfoDTO
    var results: [CharacterDetailDTO]
}

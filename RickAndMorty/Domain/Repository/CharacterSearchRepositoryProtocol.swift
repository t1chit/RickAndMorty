//
//  CharacterSearchRepositoryProtocol.swift
//  RickAndMorty
//
//  Created by Temur Chitashvili on 30.05.25.
//

import Foundation

protocol CharacterSearchRepositoryProtocol {
    func searchCharacters(query: String) async throws -> CharactersList
}

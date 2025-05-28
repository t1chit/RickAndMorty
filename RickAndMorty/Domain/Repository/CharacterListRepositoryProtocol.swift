//
//  CharacterListRepository.swift
//  RickAndMorty
//
//  Created by Temur Chitashvili on 27.05.25.
//

import Foundation

protocol CharacterListRepositoryProtocol {
    func fetchCharacterList() async throws -> CharactersList
}

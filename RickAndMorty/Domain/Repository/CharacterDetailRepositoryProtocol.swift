//
//  CharacterDetailRepositoryProtocol.swift
//  RickAndMorty
//
//  Created by Temur Chitashvili on 30.05.25.
//

import Foundation

protocol CharacterDetailRepositoryProtocol {
    func fetchCharacter(id: Int)  async throws -> CharacterDetail
}

//
//  FetchCharacterDetailUseCaseProtocol.swift
//  RickAndMorty
//
//  Created by Temur Chitashvili on 30.05.25.
//

import Foundation

protocol CharacterDetailUseCaseProtocol {
    func execute(characterID id: Int) async throws -> CharacterDetail
}

final class CharacterDetailUseCase: CharacterDetailUseCaseProtocol {
    private let repository: CharacterDetailRepositoryProtocol
    
    init(characterDetailRepository: CharacterDetailRepositoryProtocol) {
        self.repository = characterDetailRepository
    }
    
    func execute(characterID id: Int) async throws -> CharacterDetail {
        do {
            return try await repository.fetchCharacter(id: id)
        } catch {
            print("Error fetching character detail in use case: \(error)")
            throw error // Important: rethrow after logging
        }
    }
}

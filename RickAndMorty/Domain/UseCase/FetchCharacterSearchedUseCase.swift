//
//  FetchCharacterSearchedUseCase.swift
//  RickAndMorty
//
//  Created by Temur Chitashvili on 30.05.25.
//

import Foundation

protocol FetchCharacterSearchedUseCaseProtocol {
    func execute(query: String) async throws -> CharactersList
}

final class FetchCharacterSearchedUseCase: FetchCharacterSearchedUseCaseProtocol {
    private let repository: CharacterSearchRepositoryProtocol
    
    init(
        repository: CharacterSearchRepositoryProtocol
    ) {
        self.repository = repository
    }
    
    func execute(query: String) async throws -> CharactersList {
        do {
            let response: CharactersList = try await repository.searchCharacters(query: query)
            return response
        } catch {
            print("Catched error in fetchCharacterSearchedUseCase \(error)")
            throw error
        }
    }
}

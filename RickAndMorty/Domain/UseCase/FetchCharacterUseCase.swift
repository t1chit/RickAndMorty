//
//  FetchCharacterUseCaseProtocol.swift
//  RickAndMorty
//
//  Created by Temur Chitashvili on 27.05.25.
//


import Foundation

protocol FetchCharacterUseCaseProtocol {
    func execute() async throws -> CharactersList
}

final class FetchCharacterUseCase: FetchCharacterUseCaseProtocol {
    private let repository: CharacterListRepositoryProtocol
    
    init(repository: CharacterListRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() async throws -> CharactersList {
        do {
            return try await repository.fetchCharacterList()
        } catch {
            print("Error fetching character list in use case: \(error)")
            throw error // Important: rethrow after logging
        }
    }
}

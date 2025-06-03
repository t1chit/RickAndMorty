//
//  FetchCharacterUseCaseProtocol.swift
//  RickAndMorty
//
//  Created by Temur Chitashvili on 27.05.25.
//


import Foundation

protocol FetchCharacterUseCaseProtocol {
    func execute() async throws -> CharactersList
    func execute(page: Int) async throws -> CharactersList
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
    
    func execute(page: Int) async throws -> CharactersList {
        do {
            return try await repository.fetchMoreCharacters(page: page)
        } catch {
            print("Error fetching characters with pagination")
            throw error
        }
    }
}

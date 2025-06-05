//
//  FetchCharacterUseCaseProtocol.swift
//  RickAndMorty
//
//  Created by Temur Chitashvili on 27.05.25.
//


import Foundation
import Combine

protocol FetchCharacterListUseCaseProtocol {
    func execute() -> AnyPublisher<CharactersList, NetworkError>
    func execute(page: Int) async throws -> CharactersList
}

final class FetchCharacterListUseCase: FetchCharacterListUseCaseProtocol {
    private let repository: CharacterListRepositoryProtocol
    
    init(
        repository: CharacterListRepositoryProtocol
    ) {
        self.repository = repository
    }

    func execute() -> AnyPublisher<CharactersList, NetworkError> {
        return repository.fetchCharacterList()
            .handleEvents(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("Subscription error in FetchCharacterUseCase: \(error)")
                }
            })
            .eraseToAnyPublisher()
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

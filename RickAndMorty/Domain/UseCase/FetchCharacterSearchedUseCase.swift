//
//  FetchCharacterSearchedUseCase.swift
//  RickAndMorty
//
//  Created by Temur Chitashvili on 30.05.25.
//

import Foundation
import Combine

protocol FetchCharacterSearchedUseCaseProtocol {
    func execute(query: String) -> AnyPublisher<CharacterListDomain, NetworkError>
}

final class FetchCharacterSearchedUseCase: FetchCharacterSearchedUseCaseProtocol {
    private let repository: CharacterSearchRepositoryProtocol
    
    init(
        repository: CharacterSearchRepositoryProtocol
    ) {
        self.repository = repository
    }
    
    func execute(query: String) -> AnyPublisher<CharacterListDomain, NetworkError> {
        return repository.searchCharacters(query: query)
            .handleEvents(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("Subscription error in FetchCharacterSearchedUseCase: \(error)")
                }
            })
            .eraseToAnyPublisher()
        
    }
}

//
//  FetchCharacterDetailUseCaseProtocol.swift
//  RickAndMorty
//
//  Created by Temur Chitashvili on 30.05.25.
//

import Foundation
import Combine

protocol CharacterDetailUseCaseProtocol {
    func execute(characterID id: Int) -> AnyPublisher<CharacterDetail, NetworkError>
}

final class CharacterDetailUseCase: CharacterDetailUseCaseProtocol {
    private let repository: CharacterDetailRepositoryProtocol
    
    init(characterDetailRepository: CharacterDetailRepositoryProtocol) {
        self.repository = characterDetailRepository
    }
    
    func execute(characterID id: Int)-> AnyPublisher<CharacterDetail, NetworkError> {
        return repository.fetchCharacter(id: id)
            .handleEvents(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("Subscription error in CharacterDetailUseCase: \(error)")
                }
            })
            .eraseToAnyPublisher()
    }
}

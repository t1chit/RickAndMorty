//
//  CharacterDetailUseCaseProtocol.swift
//  RM_Details
//
//  Created by Temur Chitashvili on 09.06.25.
//


import Foundation
import Combine
import RM_Network_Service
import RM_Core

protocol CharacterDetailUseCaseProtocol {
    func execute(characterID id: Int) -> AnyPublisher<CharacterDetailDomain, NetworkError>
}

final class FetchCharacterDetailUseCase: CharacterDetailUseCaseProtocol {
    private let repository: CharacterDetailRepositoryProtocol
    
    init(
        characterDetailRepository: CharacterDetailRepositoryProtocol
    ) {
        self.repository = characterDetailRepository
    }
    
    func execute(characterID id: Int)-> AnyPublisher<CharacterDetailDomain, NetworkError> {
        return repository.fetchCharacter(id: id)
            .handleEvents(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("Subscription error in FetchCharacterDetailUseCaseProtocol: \(error)")
                }
            })
            .eraseToAnyPublisher()
    }
}

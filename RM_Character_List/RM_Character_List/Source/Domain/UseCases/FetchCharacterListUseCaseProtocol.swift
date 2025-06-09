//
//  FetchCharacterListUseCaseProtocol.swift
//  RM_Character_List
//
//  Created by Temur Chitashvili on 08.06.25.
//


import Foundation
import Combine
import RM_Network_Service
import RM_Core

public protocol FetchCharacterListUseCaseProtocol {
    func execute() -> AnyPublisher<CharacterListDomain, NetworkError>
    func execute(page: Int) -> AnyPublisher<CharacterListDomain, NetworkError>
}

public final class FetchCharacterListUseCase: FetchCharacterListUseCaseProtocol {
    private let repository: CharacterListRepositoryProtocol
    
    public init(
        repository: CharacterListRepositoryProtocol
    ) {
        self.repository = repository
    }
    
    public func execute() -> AnyPublisher<CharacterListDomain, NetworkError> {
        return repository.fetchCharacterList()
            .handleEvents(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("Subscription error in FetchCharacterUseCase: \(error)")
                }
            })
            .eraseToAnyPublisher()
    }
    
    public func execute(page: Int) -> AnyPublisher<CharacterListDomain, NetworkError> {
        return repository.fetchMoreCharacters(page: page)
            .handleEvents(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("Subscription error in FetchCharacterUseCase load more characters: \(error)")
                }
            })
            .eraseToAnyPublisher()
    }
}

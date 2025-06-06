//
//  CharacterListRepository.swift
//  RickAndMorty
//
//  Created by Temur Chitashvili on 27.05.25.
//

import Foundation
import Combine
import Swinject

final class CharacterListRepository: CharacterListRepositoryProtocol {
    private let networkService: NetworkServiceProtocol
    
    @Injected
    private var defaultCharacterListMapper: DefaultCharacterListMapper
    
    init(
        networkService: NetworkServiceProtocol
    ) {
        self.networkService = networkService
    }
    
    func fetchCharacterList() -> AnyPublisher<CharacterListDomain,NetworkError> {
        return networkService.reqest(
            EndPointsManager.getCharacters,
            responseType: CharactersListDTO.self
        )
        .map { [weak self] dto in
            guard let self = self else {
                fatalError("DefaultCharacterListMapper deallocated")
            }
            
            return self.defaultCharacterListMapper.map(from: dto)
        }
        .eraseToAnyPublisher()
    }
    
    func fetchMoreCharacters(page: Int) -> AnyPublisher<CharacterListDomain,NetworkError> {
        return networkService.reqest(
            EndPointsManager.getCharactersWithPagination(page: page),
            responseType: CharactersListDTO.self
        )
        .map { [weak self] dto in
            guard let self = self else {
                fatalError("DefaultCharacterListMapper deallocated")
            }
            
            return self.defaultCharacterListMapper.map(from: dto)
        }
        .eraseToAnyPublisher()
    }
}

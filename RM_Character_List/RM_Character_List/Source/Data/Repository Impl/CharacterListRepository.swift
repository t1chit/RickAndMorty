//
//  CharacterListRepository.swift
//  RM_Character_List
//
//  Created by Temur Chitashvili on 08.06.25.
//


import Foundation
import Combine
import RM_Network_Service
import RM_Core

public final class CharacterListRepository: CharacterListRepositoryProtocol {
    private let networkService: NetworkServiceProtocol
    private var defaultCharacterListMapper: DefaultCharacterListMapper
    
    public init(
        networkService: NetworkServiceProtocol,
        defaultCharacterListMapper: DefaultCharacterListMapper
    ) {
        self.networkService = networkService
        self.defaultCharacterListMapper = defaultCharacterListMapper
    }
    
    public func fetchCharacterList() -> AnyPublisher<CharacterListDomain,NetworkError> {
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
    
    public func fetchMoreCharacters(page: Int) -> AnyPublisher<CharacterListDomain,NetworkError> {
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

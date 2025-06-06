//
//  CharacterSearchReopository.swift
//  RickAndMorty
//
//  Created by Temur Chitashvili on 30.05.25.
//

import Foundation
import Combine
import Swinject
import RM_Network_Service

final class CharacterSearchReopository: CharacterSearchRepositoryProtocol {
    
    private let networkService: NetworkServiceProtocol
    
    @Injected
    private var defaultCharacterListMapper: DefaultCharacterListMapper
    
    init(
        networkService: NetworkServiceProtocol
    ) {
        self.networkService = networkService
    }
    
    func searchCharacters(query: String) -> AnyPublisher<CharacterListDomain, NetworkError> {
        return networkService.reqest(
            EndPointsManager.searchCharacter(name: query),
            responseType: CharactersListDTO.self)
        .map { dto in
            return self.defaultCharacterListMapper.map(from: dto)
        }
        .eraseToAnyPublisher()
    }
}

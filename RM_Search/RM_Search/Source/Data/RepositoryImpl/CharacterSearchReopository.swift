//
//  CharacterSearchReopository.swift
//  RM_Search
//
//  Created by Temur Chitashvili on 09.06.25.
//



import Foundation
import Combine
import Swinject
import RM_Network_Service
import RM_Character_List
import RM_Core

final class CharacterSearchReopository: CharacterSearchRepositoryProtocol {
    
    private let networkService: NetworkServiceProtocol
    
    private var defaultCharacterListMapper: DefaultCharacterListMapper
    
    init(
        networkService: NetworkServiceProtocol,
        defaultCharacterListMapper: DefaultCharacterListMapper
    ) {
        self.networkService = networkService
        self.defaultCharacterListMapper = defaultCharacterListMapper
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

//
//  CharacterListRepository.swift
//  RickAndMorty
//
//  Created by Temur Chitashvili on 27.05.25.
//

import Foundation
import Combine

final class CharacterListRepository: CharacterListRepositoryProtocol {
    private let networkService: NetworkServiceProtocol
    
    init(
        networkService: NetworkServiceProtocol
    ) {
        self.networkService = networkService
    }
    
    func fetchCharacterList() -> AnyPublisher<CharactersListDTO,NetworkError> {
        return networkService.reqest(
            EndPointsManager.getCharacters,
            responseType: CharactersListDTO.self
        )
    }
    
    func fetchMoreCharacters(page: Int) -> AnyPublisher<CharactersListDTO,NetworkError> {
        return networkService.reqest(
            EndPointsManager.getCharactersWithPagination(page: page),
            responseType: CharactersListDTO.self
        )
    }
}

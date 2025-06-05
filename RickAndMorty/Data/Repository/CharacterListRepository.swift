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

    func fetchCharacterList() -> AnyPublisher<CharactersList,NetworkError> {
        return networkService.reqest(
                EndPointsManager.getCharacters,
                responseType: CharactersList.self
            )
    }
    
    func fetchMoreCharacters(page: Int) async throws -> CharactersList {
        do {
            
            let response: CharactersList = try await networkService.request(
                EndPointsManager.getCharactersWithPagination(page: page),
                responseType: CharactersList.self
            )
            return response
        } catch {
            throw error
        }
        
    }
}

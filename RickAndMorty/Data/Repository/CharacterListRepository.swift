//
//  CharacterListRepository.swift
//  RickAndMorty
//
//  Created by Temur Chitashvili on 27.05.25.
//

import Foundation

final class CharacterListRepository: CharacterListRepositoryProtocol {
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchCharacterList() async throws -> CharactersList {
        let response: CharactersList = try await networkService.request(EndPointsManager.getCharacters,
                                                                        responseType: CharactersList.self)
        return response
    }
}

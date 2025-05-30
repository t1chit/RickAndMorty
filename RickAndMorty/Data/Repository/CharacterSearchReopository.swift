//
//  CharacterSearchReopository.swift
//  RickAndMorty
//
//  Created by Temur Chitashvili on 30.05.25.
//

import Foundation

final class CharacterSearchReopository: CharacterSearchRepositoryProtocol {
    private let networkService: NetworkServiceProtocol
    
    init(
        networkService: NetworkServiceProtocol
    ) {
        self.networkService = networkService
    }
    
    func searchCharacters(query: String) async throws -> CharactersList {
        let response: CharactersList = try await networkService.request(EndPointsManager.searchCharacter(name: query),
                                                                        responseType: CharactersList.self)
        return response
    }
}

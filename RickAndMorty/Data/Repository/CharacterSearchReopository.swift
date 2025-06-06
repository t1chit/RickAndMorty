//
//  CharacterSearchReopository.swift
//  RickAndMorty
//
//  Created by Temur Chitashvili on 30.05.25.
//

import Foundation
import Combine

final class CharacterSearchReopository: CharacterSearchRepositoryProtocol {
    
    private let networkService: NetworkServiceProtocol
    
    init(
        networkService: NetworkServiceProtocol
    ) {
        self.networkService = networkService
    }
    
    func searchCharacters(query: String) -> AnyPublisher<CharactersList, NetworkError> {
        return networkService.reqest(
            EndPointsManager.searchCharacter(name: query),
            responseType: CharactersList.self)
    }
}

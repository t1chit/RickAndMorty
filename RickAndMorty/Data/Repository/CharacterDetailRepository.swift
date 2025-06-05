//
//  CharacterDetailRepository.swift
//  RickAndMorty
//
//  Created by Temur Chitashvili on 30.05.25.
//

import Foundation
import Combine

final class CharacterDetailRepository: CharacterDetailRepositoryProtocol {
    private let networkService: NetworkServiceProtocol
    
    init(
        networkService: NetworkServiceProtocol
    ) {
        self.networkService = networkService
    }
    
    func fetchCharacter(id: Int) -> AnyPublisher<CharacterDetail,NetworkError> {
        return networkService.reqest(
            EndPointsManager.getCharacterDetials(id: id),
            responseType: CharacterDetail.self
        )
    }
}

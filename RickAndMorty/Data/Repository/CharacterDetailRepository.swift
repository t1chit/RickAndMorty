//
//  CharacterDetailRepository.swift
//  RickAndMorty
//
//  Created by Temur Chitashvili on 30.05.25.
//

import Foundation
import Combine
import Swinject

final class CharacterDetailRepository: CharacterDetailRepositoryProtocol {
    private let networkService: NetworkServiceProtocol
    @Injected
    private var defaultCharacterDetailMapper: DefaultCharacterDetailMapper
    init(
        networkService: NetworkServiceProtocol
    ) {
        self.networkService = networkService
    }
    
    func fetchCharacter(
        id: Int
    ) -> AnyPublisher<CharacterDetailDomain,NetworkError> {
        return networkService.reqest(
            EndPointsManager.getCharacterDetials(id: id),
            responseType: CharacterDetailDTO.self
        )
        .map { [weak self] dto in
            guard let self = self else {
                fatalError("DefaultCharacterListMapper deallocated")
            }
            
           return self.defaultCharacterDetailMapper.map(from: dto)
        }
        .eraseToAnyPublisher()
    }
}

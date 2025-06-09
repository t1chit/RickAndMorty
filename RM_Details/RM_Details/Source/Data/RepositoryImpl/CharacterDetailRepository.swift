//
//  CharacterDetailRepository.swift
//  RM_Details
//
//  Created by Temur Chitashvili on 09.06.25.
//

import Foundation
import Combine
import Swinject
import RM_Network_Service
import RM_Core

final class CharacterDetailRepository: CharacterDetailRepositoryProtocol {
    private let networkService: NetworkServiceProtocol
    private var defaultCharacterDetailMapper: DefaultCharacterDetailMapper

    init(
        networkService: NetworkServiceProtocol,
        defaultCharacterDetailMapper: DefaultCharacterDetailMapper
    ) {
        self.networkService = networkService
        self.defaultCharacterDetailMapper = defaultCharacterDetailMapper
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

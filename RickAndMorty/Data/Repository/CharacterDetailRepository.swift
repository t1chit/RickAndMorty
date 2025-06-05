//
//  CharacterDetailRepository.swift
//  RickAndMorty
//
//  Created by Temur Chitashvili on 30.05.25.
//

import Foundation

final class CharacterDetailRepository: CharacterDetailRepositoryProtocol {
    private let networkService: NetworkServiceProtocol
    
    init(
        networkService: NetworkServiceProtocol
    ) {
        self.networkService = networkService
    }
    
    func fetchCharacter(id: Int)  async throws -> CharacterDetail {
        do {
            let response: CharacterDetail = try await networkService.request(EndPointsManager.getCharacterDetials(id: id), responseType: CharacterDetail.self)
            
            return response
        } catch {
            throw error
        }
        
    }
}

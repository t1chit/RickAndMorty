//
//  FetchEpisodeDetailUseCase.swift
//  RM_Episodes
//
//  Created by Temur Chitashvili on 09.06.25.
//

import Combine
import RM_Network_Service

protocol FetchEpisodeDetailUseCaseProtocol {
    func execute(id: Int) -> AnyPublisher<EpisodeDomain, NetworkError>
    func executeEpisodesCharacters(withIds ids: [Int]) -> AnyPublisher<[EpisodesCharacterDomain],NetworkError>
}


final class FetchEpisodeDetailUseCase: FetchEpisodeDetailUseCaseProtocol {
    private let repository: EpisodeDetailRepositoryProtocol
    
    init(
        repository: EpisodeDetailRepositoryProtocol
    ) {
        self.repository = repository
    }
    
    func execute(id: Int) -> AnyPublisher<EpisodeDomain, NetworkError> {
        repository.getEpisode(withID: id)
    }
    
    func executeEpisodesCharacters(withIds ids: [Int]) -> AnyPublisher<[EpisodesCharacterDomain], NetworkError> {
        repository.getCharacters(ids)
    }
}

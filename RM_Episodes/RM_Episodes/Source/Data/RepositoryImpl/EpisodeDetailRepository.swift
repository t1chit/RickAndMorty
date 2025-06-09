//
//  EpisodeDetailRepository.swift
//  RM_Episodes
//
//  Created by Temur Chitashvili on 09.06.25.
//

import Combine
import RM_Network_Service
import RM_Core

final class EpisodeDetailRepository: EpisodeDetailRepositoryProtocol {
    private let networkService: NetworkServiceProtocol
    private var defaultEpisodeDetailMapper: DefaultEpisodeDetailMapper
    private var defaultEpisodeCharactersMapper: DefaultEpisodeCharactersMapper
    
    init(
        networkService: NetworkServiceProtocol,
        defaultEpisodeDetailMapper: DefaultEpisodeDetailMapper,
        defaultEpisodeCharactersMapper: DefaultEpisodeCharactersMapper
    ) {
        self.networkService = networkService
        self.defaultEpisodeDetailMapper = defaultEpisodeDetailMapper
        self.defaultEpisodeCharactersMapper = defaultEpisodeCharactersMapper
    }
    
    func getEpisode(withID id: Int) -> AnyPublisher<EpisodeDomain, NetworkError> {
        return networkService
            .reqest(EndPointsManager.getEpisode(id: id),
                    responseType: EpisodeDTO.self
            )
            .map { [weak self] dto in
                guard let self = self else {
                    fatalError("DefaultEpisodeDetailMapper deallocated")
                }
                
                return self.defaultEpisodeDetailMapper.map(from: dto)
            }
            .eraseToAnyPublisher()
    }

    func getCharacters(_ ids: [Int]) -> AnyPublisher<[EpisodesCharacterDomain], NetworkError> {
        let publishers = ids.map { id in
            networkService.reqest(
                EndPointsManager.getCharacterDetials(id: id),
                responseType: CharacterDetailDTO.self
            )
            .compactMap { [weak self] dto in
                self?.defaultEpisodeCharactersMapper.map(from: dto)
            }
            .mapError { $0 as NetworkError }
        }

        return Publishers.MergeMany(publishers)
            .collect()
            .eraseToAnyPublisher()
    }
}

//
//  EpisodeDetailRepositoryProtocol.swift
//  RM_Episodes
//
//  Created by Temur Chitashvili on 09.06.25.
//

import Combine
import RM_Network_Service
import RM_Core

protocol EpisodeDetailRepositoryProtocol {
    func getEpisode(withID id: Int) -> AnyPublisher<EpisodeDomain, NetworkError>
    func getCharacters(_ urls: [Int]) -> AnyPublisher<[EpisodesCharacterDomain], NetworkError>
}

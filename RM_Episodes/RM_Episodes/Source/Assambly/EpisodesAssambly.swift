//
//  EpisodesAssambly.swift
//  RM_Episodes
//
//  Created by Temur Chitashvili on 09.06.25.
//

import Swinject
import RM_Network_Service

public final class EpisodesAssambly: Assembly {
    public init() {}
    
    public func assemble(container: Container) {
        container.register(DefaultEpisodeDetailMapper.self) { resolver in
            DefaultEpisodeDetailMapper()
        }
        
        container.register(DefaultEpisodeCharactersMapper.self) { resolver in
            DefaultEpisodeCharactersMapper()
        }
        
        container.register(EpisodeDetailRepositoryProtocol.self) { resolver in
            EpisodeDetailRepository(networkService: resolver.resolve(NetworkService.self)!,
                                    defaultEpisodeDetailMapper: resolver.resolve(DefaultEpisodeDetailMapper.self)!,
                                    defaultEpisodeCharactersMapper: resolver.resolve( DefaultEpisodeCharactersMapper.self)!)
        }
        
        container.register(FetchEpisodeDetailUseCaseProtocol.self) { resolver in
            FetchEpisodeDetailUseCase(repository: resolver.resolve(EpisodeDetailRepositoryProtocol.self)!)
        }
    }
}

//
//  RMDetailsAssembly.swift
//  RM_Details
//
//  Created by Temur Chitashvili on 09.06.25.
//

import Swinject
import RM_Network_Service

public final class RMDetailsAssembly: Assembly {
    public init() {}
    
    public func assemble(container: Container) {
        container.register(DefaultCharacterDetailMapper.self) { _ in
            DefaultCharacterDetailMapper()
        }
        
        container.register(CharacterDetailRepositoryProtocol.self) { resolver in
            CharacterDetailRepository(networkService: resolver.resolve(NetworkService.self)!,
                                      defaultCharacterDetailMapper: resolver.resolve(DefaultCharacterDetailMapper.self)!)
        }
        
        container.register(CharacterDetailUseCaseProtocol.self) { resolver in
            FetchCharacterDetailUseCase(characterDetailRepository: resolver.resolve(CharacterDetailRepositoryProtocol.self)!)
        }
    }
}

//
//  RMDetailsAssembly.swift
//  RM_Search
//
//  Created by Temur Chitashvili on 09.06.25.
//


import Swinject
import RM_Network_Service
import RM_Character_List

public final class RMSearchAssembly: Assembly {
    public init() {}
    
    public func assemble(container: Container) {
        container.register(CharacterSearchRepositoryProtocol.self) { resolver in
            CharacterSearchReopository(networkService: resolver.resolve(NetworkService.self)!,
                                       defaultCharacterListMapper: resolver.resolve(DefaultCharacterListMapper.self)!)
        }
        
        container.register(FetchCharacterSearchedUseCaseProtocol.self) { resolver in
            FetchCharacterSearchedUseCase(repository: resolver.resolve(CharacterSearchRepositoryProtocol.self)!)
        }
    }
}

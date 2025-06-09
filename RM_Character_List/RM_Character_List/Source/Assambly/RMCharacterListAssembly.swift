//
//  RMCharacterListAssembly.swift
//  RM_Character_List
//
//  Created by Temur Chitashvili on 09.06.25.
//


import Swinject
import RM_Network_Service


public final class RMCharacterListAssembly: Assembly {
    public init() {}
    
    public func assemble(container: Container) {
        container.register(NetworkService.self) { _ in
            NetworkService()
        }
        
        container.register(DefaultCharacterListMapper.self) { _ in
            DefaultCharacterListMapper()
        }
        
        container.register(CharacterListRepositoryProtocol.self) { resolver in
            CharacterListRepository(networkService: resolver.resolve(NetworkService.self)!,
                                    defaultCharacterListMapper: resolver.resolve(DefaultCharacterListMapper.self)!)
        }
        
        container.register(FetchCharacterListUseCaseProtocol.self) { resolver in
            FetchCharacterListUseCase(repository: resolver.resolve(CharacterListRepositoryProtocol.self)!)
        }
    }
}

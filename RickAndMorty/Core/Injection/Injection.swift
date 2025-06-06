//
//  Injection.swift
//  RickAndMorty
//
//  Created by Temur Chitashvili on 27.05.25.
//

import Swinject

final class Injection {
    static let shared = Injection()
    
    var container: Container {
         get {
             return _container ?? buildContainer()
         }
         set {
             _container = newValue
         }
     }

     private var _container: Container?
    
     private func buildContainer() -> Container {
         let container = Container()
         container.register(NetworkService.self) { _ in
             NetworkService()
         }
         
         container.register(CharacterListRepositoryProtocol.self) { resolver in
             CharacterListRepository(networkService: resolver.resolve(NetworkService.self)!)
         }
         
         container.register(FetchCharacterListUseCaseProtocol.self) { resolver in
             FetchCharacterListUseCase(repository: resolver.resolve(CharacterListRepositoryProtocol.self)!)
         }
         
         container.register(CharacterDetailRepositoryProtocol.self) { resolver in
             CharacterDetailRepository(networkService: resolver.resolve(NetworkService.self)!)
         }
         
         container.register(CharacterDetailUseCaseProtocol.self) { resolver in
             FetchCharacterDetailUseCaseProtocol(characterDetailRepository: resolver.resolve(CharacterDetailRepositoryProtocol.self)!)
         }
         
         container.register(CharacterSearchRepositoryProtocol.self) { resolver in
             CharacterSearchReopository(networkService: resolver.resolve(NetworkService.self)!)
         }
         
         container.register(FetchCharacterSearchedUseCaseProtocol.self) { resolver in
             FetchCharacterSearchedUseCase(repository: resolver.resolve(CharacterSearchRepositoryProtocol.self)!)
         }
         
         return container
     }
    
    private init() {}
}

@propertyWrapper
struct Injected<Dependecy> {
    var wrappedValue: Dependecy
    
    init() {
        wrappedValue = Injection.shared.container.resolve(Dependecy.self)!
    }
}

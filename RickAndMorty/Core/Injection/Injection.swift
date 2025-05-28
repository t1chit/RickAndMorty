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
         
         container.register(CharacterListRepository.self) { resolver in
             CharacterListRepository(networkService: resolver.resolve(NetworkService.self)!)
         }
         
         container.register(FetchCharacterUseCase.self) { resolver in
             FetchCharacterUseCase(repository: resolver.resolve(CharacterListRepository.self)!)
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

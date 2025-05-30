//
//  CharacterListViewModel.swift
//  RickAndMorty
//
//  Created by Temur Chitashvili on 27.05.25.
//

import Foundation

@Observable
final class CharacterDetailViewModel {
    private let id: Int
    private let router: CharacterDetailRouter
    var characterDetail: CharacterDetail?
    private let characterDetailUseCase: CharacterDetailUseCaseProtocol
    
    init(
        id: Int,
        router: CharacterDetailRouter,
        characterDetailUseCase: CharacterDetailUseCaseProtocol
    ) {
        self.id = id
        self.router = router
        self.characterDetailUseCase = characterDetailUseCase
    }
    
    @MainActor
    func getCharacterDetail() async {
        do {
            let response = try await characterDetailUseCase.execute(characterID: id)
            characterDetail = response
        }catch {
            print("Error fetching character list in view model: \(error)")
        }
    }
    
    func navigateToCharacterList() {
        router.goBack()
    }
}

//
//  CharacterListViewModel.swift
//  RickAndMorty
//
//  Created by Temur Chitashvili on 27.05.25.
//

import Foundation

struct CharacterDetailState {
    var isLoading: Bool = false
    var characterDetail: CharacterDetail?
    var error: String?
}

enum CharacterDetailIntent {
    case onAppear
    case navigateToCharacterList
}

@Observable
final class CharacterDetailViewModel {
    private let id: Int
    private let router: CharacterDetailRouter
    private let characterDetailUseCase: CharacterDetailUseCaseProtocol
    
    var state: CharacterDetailState = .init()
    
    init(
        id: Int,
        router: CharacterDetailRouter,
        characterDetailUseCase: CharacterDetailUseCaseProtocol
    ) {
        self.id = id
        self.router = router
        self.characterDetailUseCase = characterDetailUseCase
    }
    
    func send(_ intent: CharacterDetailIntent) {
        switch intent {
        case .onAppear:
            Task {
                await getCharacterDetail()
            }
        case .navigateToCharacterList:
            navigateToCharacterList()
        }
    }
    
    @MainActor
    private func getCharacterDetail() async {
        state.isLoading = true
        state.error = nil
        
        do {
            let response = try await characterDetailUseCase.execute(characterID: id)
            state.characterDetail = response
        } catch {
            state.error = error.localizedDescription
            print("Error fetching character list in view model: \(error)")
        }
        
        state.isLoading = false
    }
    
    private func navigateToCharacterList() {
        router.goBack()
    }
}

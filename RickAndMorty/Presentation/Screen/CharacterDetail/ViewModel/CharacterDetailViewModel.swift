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
}
// MARK: - Character Detail View Model Protocol

protocol CharacterDetailViewModel: ViewModelInput, ViewModelOutput where
        Intent == CharacterListIntent,
        State == CharacterListState {}

final class DefaultCharacterDetailViewModel: ObservableObject {
    private let id: Int
    private let router: CharacterDetailRouter
    @Injected
    private var characterDetailUseCase: CharacterDetailUseCaseProtocol
    
    @Published
    var state: CharacterDetailState = .init()
    
    init(
        id: Int,
        router: CharacterDetailRouter,
    ) {
        self.id = id
        self.router = router
    }
    
    func send(_ intent: CharacterDetailIntent) {
        switch intent {
        case .onAppear:
            Task {
                await getCharacterDetail()
            }
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
}

//
//  CharacterListViewModel.swift
//  RickAndMorty
//
//  Created by Temur Chitashvili on 27.05.25.
//

import Foundation
import Combine

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
    private var cancellables: Set<AnyCancellable> = []

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

                getCharacterDetail()
        }
    }
    
    private func getCharacterDetail() {
        state.isLoading = true
        state.error = nil
        
        characterDetailUseCase.execute(characterID: id)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.state.isLoading = false
                
                if case let .failure(error) = completion {
                    self?.state.error = error.localizedDescription
                    print("Error fetching characters details: \(error)")
                }
            } receiveValue: { [weak self] response in
                self?.state.characterDetail = response
            }
            .store(in: &cancellables)
    }
}

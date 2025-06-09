//
//  DefaultCharacterDetailViewModel.swift
//  RM_Details
//
//  Created by Temur Chitashvili on 09.06.25.
//


import Foundation
import Combine
import RM_Network_Service
import RM_Core
import RM_Episodes

public struct CharacterDetailState {
    var isLoading: Bool = false
    var characterDetail: CharacterDetailDomain?
    var error: String?
}

public enum CharacterDetailIntent {
    case onAppear
    case episode(id: Int)
}
// MARK: - Character Detail View Model Protocol

protocol CharacterDetailViewModel: ViewModelInput, ViewModelOutput where
        Intent == CharacterDetailIntent,
        State == CharacterDetailState {}

final class DefaultCharacterDetailViewModel: ObservableObject {
    private let id: Int
    private let router: CharacterDetailRouter
    private var characterDetailUseCase: CharacterDetailUseCaseProtocol
    private var cancellables: Set<AnyCancellable> = []

    @Published
    var state: CharacterDetailState = .init()
    
    init(
        id: Int,
        router: CharacterDetailRouter,
        characterDetailUseCase: CharacterDetailUseCaseProtocol,
    ) {
        self.id = id
        self.router = router
        self.characterDetailUseCase = characterDetailUseCase
    }
    
    func send(_ intent: CharacterDetailIntent) {
        switch intent {
        case .onAppear:
                getCharacterDetail()
        case .episode(let id):
            Task {
                await router.presentEpisodes(withID: id)
            }
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

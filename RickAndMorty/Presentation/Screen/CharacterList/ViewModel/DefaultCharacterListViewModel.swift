//
//  CharacterListViewModel.swift
//  RickAndMorty
//
//  Created by Temur Chitashvili on 27.05.25.
//

import Foundation
import Combine
import RM_Network_Service

// MARK: - State

struct CharacterListState {
    var isloading: Bool = false
    var characterList: CharacterListDomain?
    var moreCharactersAreLoading: Bool = false
    var error: String?
    var page: Int = 1
}

// MARK: - Intent

enum CharacterListIntent {
    case characterSelected(withID: Int)
    case loadMoreCharacters
}

// MARK: - Character List View Model Protocol

protocol CharacterListViewModel: ViewModelInput, ViewModelOutput where
Intent == CharacterListIntent,
State == CharacterListState {}

// MARK: - Character List View Model

final class DefaultCharacterListViewModel: ObservableObject {
    private let router: CharacterListRouter
    @Injected
    private var characterListUseCase: FetchCharacterListUseCaseProtocol
    
    @Published var state: CharacterListState = .init()
    private var cancellables: Set<AnyCancellable> = []
    
    init(
        router: CharacterListRouter,
    ) {
        self.router = router
        fetchCharacters()
    }
    
    private func fetchCharacters() {
        state.isloading = true
        state.error = nil
        
        characterListUseCase.execute()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.state.isloading = false

                if case let .failure(error) = completion {
                    self?.state.error = error.localizedDescription
                    print("Error fetching characters: \(error)")
                }
            } receiveValue: { [weak self] response in
                self?.state.characterList = response
            }
            .store(in: &cancellables)
        
    }
    
    private func fetchMoreCharacters() {
        state.moreCharactersAreLoading = true
        state.error = nil
        state.page += 1
        
        characterListUseCase.execute(page: state.page)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.state.moreCharactersAreLoading = false

                if case let .failure(error) = completion {
                    self?.state.error = error.localizedDescription
                    print("Error fetching characters: \(error)")
                }
            } receiveValue: { [weak self] response in
                self?.state.characterList?.characterList.append(contentsOf: response.characterList)
            }
            .store(in: &cancellables)
        
    }
    
    private func navigateToDetails(withID id: Int) async {
        await router.routeToDetailPage(withID: id)
    }
    
    func send(_ intent: CharacterListIntent) {
        switch intent {
        case .characterSelected(let id):
            Task {
                await navigateToDetails(withID: id)
            }
        case .loadMoreCharacters:
            fetchMoreCharacters()
        }
    }
}

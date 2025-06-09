//
//  DefaultCharacterListViewModel.swift
//  RM_Character_List
//
//  Created by Temur Chitashvili on 08.06.25.
//

import Foundation
import Combine
import RM_Network_Service
import RM_Core

// MARK: - State

public struct CharacterListState {
    var isloading: Bool = false
    var characterList: CharacterListDomain?
    var moreCharactersAreLoading: Bool = false
    var error: String?
    var page: Int = 1
}

// MARK: - Intent

public enum CharacterListIntent {
    case characterSelected(withID: Int)
    case loadMoreCharacters
}

// MARK: - Character List View Model Protocol

public protocol CharacterListViewModel: ViewModelInput, ViewModelOutput where
        Intent == CharacterListIntent,
        State == CharacterListState {}

// MARK: - Character List View Model

public final class DefaultCharacterListViewModel: ObservableObject {
    private let router: CharacterListRouter

    private var characterListUseCase: FetchCharacterListUseCaseProtocol
    
    @Published var state: CharacterListState = .init()
    private var cancellables: Set<AnyCancellable> = []
    
    public init(
        router: CharacterListRouter,
        characterListUseCase: FetchCharacterListUseCaseProtocol,
    ) {
        self.router = router
        self.characterListUseCase = characterListUseCase
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
    
    public func send(_ intent: CharacterListIntent) {
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

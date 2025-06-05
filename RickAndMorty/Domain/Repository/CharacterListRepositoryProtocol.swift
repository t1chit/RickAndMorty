//
//  CharacterListRepository.swift
//  RickAndMorty
//
//  Created by Temur Chitashvili on 27.05.25.
//

import Foundation
import Combine

protocol CharacterListRepositoryProtocol {
    func fetchCharacterList() -> AnyPublisher<CharactersList, NetworkError>
    func fetchMoreCharacters(page: Int) async throws -> CharactersList
}

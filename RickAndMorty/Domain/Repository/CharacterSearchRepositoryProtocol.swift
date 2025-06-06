//
//  CharacterSearchRepositoryProtocol.swift
//  RickAndMorty
//
//  Created by Temur Chitashvili on 30.05.25.
//

import Foundation
import Combine

protocol CharacterSearchRepositoryProtocol {
    func searchCharacters(query: String) -> AnyPublisher<CharactersList, NetworkError>
}

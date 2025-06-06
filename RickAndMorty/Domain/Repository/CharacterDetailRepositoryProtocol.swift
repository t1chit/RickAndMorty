//
//  CharacterDetailRepositoryProtocol.swift
//  RickAndMorty
//
//  Created by Temur Chitashvili on 30.05.25.
//

import Foundation
import Combine

protocol CharacterDetailRepositoryProtocol {
    func fetchCharacter(id: Int)  -> AnyPublisher<CharacterDetailDTO, NetworkError>
}

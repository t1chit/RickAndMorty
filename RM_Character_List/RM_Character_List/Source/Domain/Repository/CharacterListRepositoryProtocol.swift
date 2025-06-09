//
//  CharacterListRepositoryProtocol.swift
//  RM_Character_List
//
//  Created by Temur Chitashvili on 08.06.25.
//


import Foundation
import Combine
import RM_Network_Service
import RM_Core

public protocol CharacterListRepositoryProtocol {
    func fetchCharacterList() -> AnyPublisher<CharacterListDomain, NetworkError>
    func fetchMoreCharacters(page: Int) -> AnyPublisher<CharacterListDomain, NetworkError>
}

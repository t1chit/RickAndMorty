//
//  CharacterDetailRepositoryProtocol.swift
//  RM_Details
//
//  Created by Temur Chitashvili on 09.06.25.
//


import Foundation
import Combine
import RM_Network_Service
import RM_Core

protocol CharacterDetailRepositoryProtocol {
    func fetchCharacter(id: Int)  -> AnyPublisher<CharacterDetailDomain, NetworkError>
}

//
//  EpisodesCharacter.swift
//  RM_Episodes
//
//  Created by Temur Chitashvili on 09.06.25.
//

import Foundation

struct EpisodesCharacterDomain: Decodable, Identifiable {
    let id: Int
    let name: String
    let image: String
}

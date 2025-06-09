//
//  CharacterListDomain.swift
//  RM_Core
//
//  Created by Temur Chitashvili on 07.06.25.
//

import Foundation

public struct CharacterListDomain: Decodable {
    public  var characterList: [CharacterCardDomain]
    public let nextPage: String?
    
    public init(
        characterList: [CharacterCardDomain],
        nextPage: String?
    ) {
        self.characterList = characterList
        self.nextPage = nextPage
    }
}



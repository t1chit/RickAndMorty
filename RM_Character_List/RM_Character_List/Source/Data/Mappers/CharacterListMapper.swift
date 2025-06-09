//
//  CharacterListMapper.swift
//  RM_Character_List
//
//  Created by Temur Chitashvili on 08.06.25.
//


import Foundation
import RM_Core

public protocol CharacterListMapper: MapperFromDTOToDomain where
        DTO == CharactersListDTO,
        Domain == CharacterListDomain { }

public final class DefaultCharacterListMapper: CharacterListMapper {
    public init() { }
    
    public func map(
        from dto: CharactersListDTO
    ) -> CharacterListDomain {
        let characters = dto.results.map { characterDTO in
            CharacterCardDomain(
                id: characterDTO.id,
                name: characterDTO.name,
                image: characterDTO.image,
                gender: characterDTO.gender
            )
        }
        
        return CharacterListDomain(
            characterList: characters,
            nextPage: dto.info.next
        )
    }
}

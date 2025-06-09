//
//  EpisodeCharactersMapper.swift
//  RM_Episodes
//
//  Created by Temur Chitashvili on 09.06.25.
//

import Foundation
import RM_Core

protocol EpisodeCharactersMapper: MapperFromDTOToDomain where
        DTO == CharacterDetailDTO,
        Domain == EpisodesCharacterDomain { }

final class DefaultEpisodeCharactersMapper: EpisodeCharactersMapper {
    func map(
        from dto: CharacterDetailDTO
    ) -> EpisodesCharacterDomain {
        return .init(
            id: dto.id,
            name: dto.name,
            image: dto.image
        )
    }
}

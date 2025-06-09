//
//  CharacterDetailMapper.swift
//  RM_Episodes
//
//  Created by Temur Chitashvili on 09.06.25.
//


import Foundation
import RM_Core

protocol EpisodeDetailMapper: MapperFromDTOToDomain where
        DTO == EpisodeDTO,
        Domain == EpisodeDomain { }

final class DefaultEpisodeDetailMapper: EpisodeDetailMapper {
    func map(
        from dto: EpisodeDTO
    ) -> EpisodeDomain {
        return .init(
            id: dto.id,
            name: dto.name,
            airDate: dto.airDate,
            episode: dto.episode,
            characters: dto.characters
        )
    }
}

//
//  Episode.swift
//  RM_Episodes
//
//  Created by Temur Chitashvili on 09.06.25.
//

import Foundation

struct EpisodeDTO: Codable, Identifiable {
    let id: Int
    let name: String
    let airDate: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case airDate = "air_date"
        case episode
        case characters
        case url
        case created
    }
}

//
//  Episode.swift
//  RM_Episodes
//
//  Created by Temur Chitashvili on 09.06.25.
//

import Foundation

struct EpisodeDomain: Decodable, Identifiable {
    let id: Int
    let name: String
    let airDate: String
    let episode: String
    let characters: [String]
}

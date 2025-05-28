//
//  InfoDTO.swift
//  CleanRickAndMorty
//
//  Created by Temur Chitashvili on 23.05.25.
//

import Foundation

struct Info: Decodable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

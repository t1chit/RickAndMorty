//
//  NetworkError.swift
//  CleanRickAndMorty
//
//  Created by Temur Chitashvili on 23.05.25.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case decodingFailed
    case serverError(String)
    case unknown
}

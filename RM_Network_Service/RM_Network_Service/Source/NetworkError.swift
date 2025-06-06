//
//  NetworkError.swift
//  RM_Network_Service
//
//  Created by Temur Chitashvili on 06.06.25.
//


import Foundation

public enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case decodingFailed
    case serverError(String)
    case unknown
}

//
//  NetworkService.swift
//  CleanRickAndMorty
//
//  Created by Temur Chitashvili on 23.05.25.
//

import Foundation
import Combine

protocol NetworkServiceProtocol {
    func request<T: Decodable>(
        _ endpoint: Endpoint,
        responseType: T.Type
    ) async throws -> T
    
    func reqest<T: Decodable>(
        _ endpoint: Endpoint,
        responseType: T.Type
    ) -> AnyPublisher<T, NetworkError>
}

final class NetworkService: NetworkServiceProtocol {
    func reqest<T: Decodable>(
        _ endpoint: any Endpoint,
        responseType: T.Type
    ) -> AnyPublisher<T,NetworkError> {
        guard let request = endpoint.urlRequest else {
            return Fail(error: NetworkError.invalidURL)
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse,
                      (200..<300).contains(httpResponse.statusCode) else {
                    throw NetworkError.invalidResponse
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error -> NetworkError in
                if let _  = error as? DecodingError {
                    return .decodingFailed
                } else {
                    return .unknown
                }
            }
            .eraseToAnyPublisher()
    }
    
    func request<T: Decodable>(
        _ endpoint: Endpoint,
        responseType: T.Type
    ) async throws -> T {
        guard let request = endpoint.urlRequest else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            throw NetworkError.invalidResponse
        }
        
        do {
            let decoded = try JSONDecoder().decode(T.self, from: data)
            return decoded
        } catch {
            throw NetworkError.decodingFailed
        }
    }
}

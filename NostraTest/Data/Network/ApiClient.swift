//
//  ApiClient.swift
//  NostraTest
//
//  Created by Vokal-Ican on 21/09/26.
//

import Foundation

protocol APIClientProtocol {
    func get<T: Decodable> (_ endpoint: Endpoint) async throws -> T
}

final class ApiClient: APIClientProtocol {
    private let session: URLSession
    private let decoder: JSONDecoder
    
    init(session: URLSession = .shared) {
        self.session = session
        self.decoder = JSONDecoder()
    }
    
    func get<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        guard let url = endpoint.url() else {
            throw APIError.invalidURL
        }
        
        let data: Data
        let response: URLResponse
        
        do {
            (data, response) = try await session.data(from: url)
        } catch {
            throw APIError.transport(error)
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw APIError.httpStatus(httpResponse.statusCode)
        }
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw APIError.decoding(error)
        }
    }
}

//
//  DataService.swift
//  FakeStoreAPI
//
//  Created by Osman M. on 30/05/2024.
//

import Foundation


protocol HTTPDataDownloader {
    func fetchData <T: Decodable>(as type: T.Type, endpoint: String) async throws -> T
    func postData<T: Decodable, U: Encodable>(as type: T.Type, to endpoint: String, body: U) async throws -> T
}

extension HTTPDataDownloader {
    func fetchData <T: Decodable>(as type: T.Type, endpoint: String) async throws -> T {
        guard let url = URL(string: endpoint) else {
            throw APIError.requestFailed(description: "Invalid URL")
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.requestFailed(description: "Request failed")
        }
        guard httpResponse.statusCode == 200 else {
            throw APIError.invalidStatusCode(statuscode: httpResponse.statusCode)
        }
        do {
            return try JSONDecoder().decode(type, from: data)
        } catch {
            throw error as? APIError ?? .decodingError(error: error)
        }
    }
    
    func postData<T: Decodable, U: Encodable>(as type: T.Type, to endpoint: String, body: U) async throws -> T {
            guard let url = URL(string: endpoint) else {
                throw APIError.requestFailed(description: "Invalid URL")
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            do {
                let jsonData = try JSONEncoder().encode(body)
                request.httpBody = jsonData
            } catch {
                throw APIError.encodingError(error: error)
            }
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.requestFailed(description: "Request failed")
            }
            guard httpResponse.statusCode == 200 else {
                throw APIError.invalidStatusCode(statuscode: httpResponse.statusCode)
            }
            
            do {
                return try JSONDecoder().decode(type, from: data)
            } catch {
                throw error as? APIError ?? .decodingError(error: error)
            }
        }
}




//
//  APIErrors.swift
//  FakeStoreAPI
//
//  Created by Osman M. on 30/05/2024.
//

import Foundation


enum APIError: Error {
    case requestFailed(description: String)
    case invalidStatusCode(statuscode: Int)
    case decodingError(error: Error)
    case encodingError(error: Error)
    
    var customDescription: String {
        switch self {
        case .requestFailed(let description):
            return "Request failed: \(description)"
        case .invalidStatusCode(let statuscode):
            return "Invalid status code \(statuscode)"
        case .decodingError(let error):
            return "Decoding error \(error)"
        case .encodingError(error: let error):
            return "Encoding error \(error)"
        }
    }
}

//
//  RequestError.swift
//  iOSApiNews
//
//  Created by Higor  Lo Castro on 15/05/24.
//

// RequestError.swift

import Foundation

enum RequestError: Error {
    case invalidURL
    case wordNotFound
    case decodingError
    case errorRequest(error: String)
    
    var errorMessage: String {
        switch self {
        case .invalidURL:
            return "Invalid URL."
        case .wordNotFound:
            return "Word not found."
        case .decodingError:
            return "Decoding error."
        case .errorRequest(let errorDescription):
            return "Request error: \(errorDescription)"
        }
    }
}

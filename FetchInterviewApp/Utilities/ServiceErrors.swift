//
//  ServiceErrors.swift
//  FetchInterviewApp
//
//  Created by Alexandre12 on 12/12/24.
//

import Foundation

enum ServiceErrors: Error {
    case decoding
    case invalidURL
    case emptyData
}

extension ServiceErrors: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .decoding:
            return "Unable to decode the JSON"
        case .invalidURL:
            return "Unable to create the URL"
        case .emptyData:
            return "No data found at this time. Try again later."
        }
    }
}


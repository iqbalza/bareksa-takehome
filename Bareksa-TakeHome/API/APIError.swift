//
//  APIError.swift
//  Bareksa-TakeHome
//
//  Created by Iqbal Zauqul Adib on 19/01/22.
//

import Foundation

enum APIError: Error {
    case decodingFailed
    case serverError(error: String)
    case noInternet
    case invalidUrl
    
    var localizedDescription: String {
        switch self {
        case .decodingFailed:
            return "Failed to decode JSON"
        case .noInternet:
            return "No Internet"
        case .serverError(let error):
            return "Bad response: \(error)"
        case .invalidUrl:
            return "URL invalid"
        }
    }
}

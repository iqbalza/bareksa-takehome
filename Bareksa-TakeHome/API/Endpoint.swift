//
//  Endpoint.swift
//  Bareksa-TakeHome
//
//  Created by Iqbal Zauqul Adib on 19/01/22.
//

import Foundation

enum Endpoint {
    
    // MARK: - Endpoints
    case getProducts(productCodes: [String])
    
    case getChartData(productCodes: [String])
    
    var baseURL: String {
        switch self {
        default:
            return "ae1cdb19-2532-46fa-9b8f-cce01702bb1e.mock.pstmn.io"
        }
    }
    
    var method: String {
        switch self {
        default:
            return "GET"
        }
    }
    
    var query: [URLQueryItem] {
        switch self {
       
        case .getProducts(let productCodes):
            var queries = [URLQueryItem]()
            for productCode in productCodes {
                queries.append(URLQueryItem(name: "productCodes", value: productCode))
            }
            
            return queries
            
        case .getChartData(let productCodes):
            var queries = [URLQueryItem]()
            for productCode in productCodes {
                queries.append(URLQueryItem(name: "productCodes", value: productCode))
            }
            
            return queries
        }
    
    }
    
    var path: String {
        switch self {
        case .getProducts:
            return "/takehometest/apps/compare/detail"
        case .getChartData:
            return "/takehometest/apps/compare/chart"
        }
    }
    
    var scheme: String {
        switch self {
        default:
            return "https"
        }
    }
}

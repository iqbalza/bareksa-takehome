//
//  ChartDataResponse.swift
//  Bareksa-TakeHome
//
//  Created by Iqbal Zauqul Adib on 19/01/22.
//

import Foundation

// MARK: - ChartDataResponse
struct ChartDataResponse: Codable {
    let code: Int
    let message: String
    let error: String
    let data: [String: ChartData]
    let total_data: Int
    
    // MARK: - DatumValue
    struct ChartData: Codable {
        let data: [Data]
        let error: String
    }

    // MARK: - DatumElement
    struct Data: Codable {
        let date: String
        let value: Double
        let growth: Double
    }
    
}



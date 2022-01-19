//
//  ProductDetailResponse.swift
//  Bareksa-TakeHome
//
//  Created by Iqbal Zauqul Adib on 19/01/22.
//

import Foundation

// MARK: - ProductDetailResponse
struct ProductDetailResponse: Codable {
    let code: Int
    let message: String
    let error: String
    let data: [Product]
    let total_data: Int
    
    // MARK: - Datum
    struct Product: Codable {
        let code: String
        let name: String
        let details: Details
    }

    // MARK: - Details
    struct Details: Codable {
        let category: String
        let category_id: Int
        let currency: String
        let custody: String
        let inception_date: String
        let im_avatar: String
        let im_name: String
        let min_balance: Int
        let min_redemption: Int
        let min_subscription: Int
        let nav: Double
        let return_cur_year: Double
        let return_five_year: Double
        let return_four_year: Double
        let return_inception_growth: Double
        let return_one_day: Double
        let return_one_month: Double
        let return_one_week: Double
        let return_one_year: Double
        let return_six_month: Double
        let return_three_month: Double
        let return_three_year: Double
        let return_two_year: Double
        let total_unit: Int
        let type: String
        let type_id: Int
    }

}


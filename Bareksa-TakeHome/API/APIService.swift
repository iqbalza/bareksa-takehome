//
//  APIService.swift
//  Bareksa-TakeHome
//
//  Created by Iqbal Zauqul Adib on 19/01/22.
//

import Foundation
import RxSwift

protocol APIServiceProtocol{
    func getProducts(productCodes: [String]) -> Single<ProductDetailResponse>
    func getCharts(productCodes: [String]) -> Single<ChartDataResponse>
}

struct ApiService: APIServiceProtocol {
    
    func getProducts(productCodes: [String]) -> Single<ProductDetailResponse> {
       return APIManager.shared.execute(endpoint: .getProducts(productCodes: productCodes))
    }
    
    func getCharts(productCodes: [String]) -> Single<ChartDataResponse> {
        return APIManager.shared.execute(endpoint: .getChartData(productCodes: productCodes))
    }
    
}

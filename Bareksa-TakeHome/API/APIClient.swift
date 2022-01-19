//
//  APIClient.swift
//  Bareksa-TakeHome
//
//  Created by Iqbal Zauqul Adib on 19/01/22.
//

import Foundation
import RxSwift

protocol APIManagerProtocol {
    func execute<T: Codable>( endpoint: Endpoint) -> Single<T>
}

struct APIManager: APIManagerProtocol {
    
    static let shared = APIManager()
    
    private init() {}
    
    func execute<T: Codable>( endpoint: Endpoint) -> Single<T>   {
        
      return Single<T>.create { observer in
        var components = URLComponents()
        components.scheme = endpoint.scheme
        components.host = endpoint.baseURL
        components.path = endpoint.path
        components.queryItems = endpoint.query
        
        guard let url = components.url else {
            observer(.failure(APIError.invalidUrl))
            return Disposables.create()
        }
          
//        print(url)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method
                  
       let task = URLSession.shared.dataTask(with: urlRequest) { (data,response,error) in
            guard let data = data, let httpResponse = response as? HTTPURLResponse else {
                //No data
                observer(.failure(APIError.serverError(error: error!.localizedDescription)))
                print("\(String(describing: error))")
                return
            }
            
            guard 200...299 ~= httpResponse.statusCode else {
                observer(.failure(APIError.serverError(error: "Http Error: \(httpResponse.statusCode)")))
                let outputStr  = String(data: data, encoding: String.Encoding.utf8)
                print("\(endpoint.path) Error \(httpResponse.statusCode), \(String(describing: outputStr))")
                return
            }
            
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                observer(.success(result))
            } catch(let e) {
                print("Decoding Error: \(endpoint.path) ")
                print(String(describing:e))
                observer(.failure(APIError.decodingFailed))
            }
        }
          task.resume()
          return Disposables.create {
              task.cancel()
          }
      }
    }
    
    
}

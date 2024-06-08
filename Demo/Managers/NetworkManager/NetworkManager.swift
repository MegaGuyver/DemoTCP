//
//  NetworkManager.swift
//  Demo
//
//  Created by khawaja fahad on 07/06/2024.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func executeRequest<T>(url: String, method: HTTPMethod = .get,
                           parameters: Parameters? = nil,
                           encoding: ParameterEncoding = URLEncoding.default,
                           headers: HTTPHeaders = HTTPHeaders.default,
                           completionHandler: @escaping (Result<T, Error>) -> Void) where T: Codable {
        
        let request = AF.request(url, method: method, parameters: nil, encoding: URLEncoding.default, headers: headers)
        
        request.validate().responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(.success(value))
                
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}





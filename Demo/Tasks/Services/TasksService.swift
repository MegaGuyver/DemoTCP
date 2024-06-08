//
//  TasksService.swift
//  Demo
//
//  Created by khawaja fahad on 07/06/2024.
//

import Foundation
import Alamofire

protocol TasksServiceProtocol {
    func getTasks(completion: @escaping (Result<TasksModel, Error>) -> Void)
}

class TasksService: TasksServiceProtocol {
  
    func getTasks(completion: @escaping (Result<TasksModel, Error>) -> Void) {
        
        NetworkManager.shared.executeRequest(url: "http://demo1414406.mockable.io/") { (result: Result<TasksModel, Error>) in
            switch result {
            case .success(let tasks):
                completion(.success(tasks))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

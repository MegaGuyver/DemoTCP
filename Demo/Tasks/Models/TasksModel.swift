//
//  TasksModel.swift
//  Demo
//
//  Created by khawaja fahad on 07/06/2024.
//

import Foundation

struct TasksModel: Codable {
    let tasks: [TaskModel]
    
    enum CodingKeys: String, CodingKey {
        case tasks = "tasks"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        tasks = try container.decode([TaskModel].self, forKey: .tasks)
    }
}

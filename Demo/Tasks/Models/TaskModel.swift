//
//  TaskModel.swift
//  Demo
//
//  Created by khawaja fahad on 07/06/2024.
//

import Foundation

struct TaskModel: Identifiable, Codable {
    let id: String
    let targetDate: String
    var dueDate: String?
    let title: String
    var description: String
    let priority: Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case targetDate = "TargetDate"
        case dueDate = "DueDate"
        case title = "Title"
        case description = "Description"
        case priority = "Priority"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        targetDate = try container.decode(String.self, forKey: .targetDate)
        dueDate = try container.decodeIfPresent(String.self, forKey: .dueDate)
        title = try container.decode(String.self, forKey: .title)
        description = try container.decode(String.self, forKey: .description)
        priority = try container.decodeIfPresent(Int.self, forKey: .priority)
    }
}

 
extension TaskModel: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

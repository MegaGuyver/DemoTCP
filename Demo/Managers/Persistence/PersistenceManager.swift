//
//  PersistenceManager.swift
//  Demo
//
//  Created by khawaja fahad on 08/06/2024.
//

import Foundation

class PersistenceManager {
    
    static let shared = PersistenceManager()
        
    var storedTasks: Set<TaskModel> = []
    
    private init() {
        load()
    }
    
    func save(tasks: Set<TaskModel>) {
        do {
            let encodedData = try JSONEncoder().encode(tasks)

            let userDefaults = UserDefaults.standard
            userDefaults.set(encodedData, forKey: "tasks")

        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func load() {
        
        let userDefaults = UserDefaults.standard
        if let savedData = userDefaults.object(forKey: "tasks") as? Data {
            do{
                storedTasks = try JSONDecoder().decode(Set<TaskModel>.self, from: savedData)

            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }
}

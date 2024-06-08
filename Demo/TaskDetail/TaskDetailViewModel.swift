//
//  TaskDetailViewModel.swift
//  Demo
//
//  Created by khawaja fahad on 08/06/2024.
//

import Foundation

class TaskDetailViewModel {
    
    var task: TaskTableViewCellViewModel
    
    var updateDate: ((String, String) -> Void)?
    
    init(task: TaskTableViewCellViewModel) {
        self.task = task
    }
}

// MARK: Date Helpers
extension TaskDetailViewModel {
    
    func getTaskDate() -> Date {
        
        guard let taskDate =  task.object.dueDate?.toDate() else {
            return Date()
        }
        
        return taskDate
    }
    
    func updateDate(dueDate: Date) {
        
       let daysLeftString = String(Calendar.current.numberOfDaysBetween(Date(), and: dueDate))
       let dueDateString = dueDate.toString(withFormat: "MMM d yyyy")
        
        updateDate?(dueDateString, daysLeftString)
    }
}

// MARK: Update Task
extension TaskDetailViewModel {
    
    func updateTask(updatedescription: String) {
        
        guard var storeTask = PersistenceManager.shared.storedTasks.filter({$0.id == task.object.id}).first else {
            return
        }
        
        guard let index = PersistenceManager.shared.storedTasks.firstIndex(where: {$0.id == task.object.id}) else {
            return
        }

        storeTask.description = updatedescription
        
        PersistenceManager.shared.storedTasks.remove(at: index)
        PersistenceManager.shared.storedTasks.insert(storeTask)
        
        saveObject(tasks: PersistenceManager.shared.storedTasks)
    }
    
    func updateTask(date: Date) {
        
        guard var storeTask = PersistenceManager.shared.storedTasks.filter({$0.id == task.object.id}).first else {
            return
        }
        
        guard let index = PersistenceManager.shared.storedTasks.firstIndex(where: {$0.id == task.object.id}) else {
            return
        }
        
        storeTask.dueDate = date.toString(withFormat: "yyyy-MM-dd")
    
        PersistenceManager.shared.storedTasks.remove(at: index)
        PersistenceManager.shared.storedTasks.insert(storeTask)
        
        saveObject(tasks: PersistenceManager.shared.storedTasks)
        
        updateDate(dueDate: date)
        
        self.task.object = storeTask
    }
    
    func saveObject(tasks: Set<TaskModel>) {
        PersistenceManager.shared.save(tasks: tasks)
    }
}

//
//  TasksViewModel.swift
//  Demo
//
//  Created by khawaja fahad on 07/06/2024.
//

import Foundation

enum DateRequired {
    case tomorrow
    case yesterday
}

class TasksViewModel {
    
    private var tasksService: TasksServiceProtocol
    
    private var currentDate = Date()
    private var currentDateString = Date().toString(withFormat: "yyyy-MM-dd")
    
    private var serviceCallMade = false
    
    var tasks = [TaskModel]()
    var tasksArranged = [String: [TaskModel]]()
    
    lazy private var dateFormatter: DateFormatter = {
        let datef = DateFormatter()
        datef.dateFormat = "EEE MMM d"
        datef.timeZone = .current
        return datef
    }()
    
    
    var reloadTableView: (() -> Void)?
    var updateTitle: ((String) -> Void)?
    
    var showLoader: ((String?) -> Void)?
    var hideLoader: (() -> Void)?
    
    init(tasksService: TasksServiceProtocol = TasksService()) {
        self.tasksService = tasksService
        
        PersistenceManager.shared.load()
    }
}

// MARK: Get Date
extension TasksViewModel {
    
    func getDateText(dateRequired: DateRequired) {
        
        var updatedString:String!
        
        switch dateRequired {
        case .tomorrow:
             updatedString =  getStringFromFormatter(updateDay: 1)
        case .yesterday:
            updatedString =  getStringFromFormatter(updateDay: -1)
        }
        
        updateTitle?(updatedString)
        reloadTableView?()
    }
    

    func getStringFromFormatter(updateDay: Int) -> String {
        if let modifiedDate = Calendar.current.date(byAdding: .day, value: updateDay, to: currentDate) {
            currentDate = modifiedDate
            currentDateString = currentDate.toString(withFormat: "yyyy-MM-dd")
            
            if Calendar.current.isDate(currentDate, equalTo: Date(), toGranularity: .day) {
                return "Today"
            }
           return dateFormatter.string(from: modifiedDate)
        }
        return dateFormatter.string(from: Date())
    }
}

// MARK: TableView Helpers
extension TasksViewModel {
    
    func tableView( numberOfRowsInSection section: Int) -> Int {

        if let rows =  tasksArranged[currentDateString]?.count {
            return rows
        } else {
            return 0
        }
     
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> TaskTableViewCellViewModel {
        
         let object = tasksArranged[currentDateString]![indexPath.row]
        
         var dueDateString  = ""
         var daysLeftString = ""
        
        if let dueDateInternalString = object.dueDate {
            
            if let dueDate = dueDateInternalString.toDate() {
                
                daysLeftString = String(Calendar.current.numberOfDaysBetween(Date(), and: dueDate))
            
                dueDateString = dueDate.toString(withFormat: "MMM d yyyy")
            }
        }
        
        return  TaskTableViewCellViewModel(title: object.title, dueDate: dueDateString, daysLeft: daysLeftString , object: object)
          
    }
    
}


// MARK: Get Tasks
extension TasksViewModel {
    
    func getTasks() {
        
        showLoader?("Please wait")
        
        tasksService.getTasks { [weak self] result in
            guard let self = self else { return }
            
            serviceCallMade = true
            
            if case .success(let response) = result {
                updatePresistedData(taskFromServer: response.tasks)
                updateTasks()
            }
            if case .failure(let error) = result {
                print(error)
            }
            
            hideLoader?()
        }
    }
    
    func updateTasks() {
        
        if serviceCallMade {
            
            tasks = Array(PersistenceManager.shared.storedTasks)
            tasksArranged  = [:]
            
            organizeTasks()
            saveObject()
            reloadTableView?()
        }
    }
    
    func updatePresistedData(taskFromServer: [TaskModel]) {
        
        for task in taskFromServer {
            
            if !PersistenceManager.shared.storedTasks.contains(where: {$0.id == task.id}) {
                PersistenceManager.shared.storedTasks.insert(task)
            }
        }
    }
    
    func organizeTasks() {
        
        for task in tasks {
            if tasksArranged[task.targetDate] != nil {
                
                if let taskArray = tasksArranged[task.targetDate] {
                    if !taskArray.contains(where: { $0.id == task.id}) {
                        tasksArranged[task.targetDate]?.append(task)

                        tasksArranged[task.targetDate] = tasksArranged[task.targetDate]?.sorted(by: {$0.priority ?? 0 > $1.priority ?? 0})
                    }
                }
                } else {
                    tasksArranged[task.targetDate] = [task]
            }
        }
    }
    
    func saveObject() {
        PersistenceManager.shared.save(tasks: PersistenceManager.shared.storedTasks)
    }
}

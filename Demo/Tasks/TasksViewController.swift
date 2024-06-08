//
//  TasksViewController.swift
//  Demo
//
//  Created by khawaja fahad on 07/06/2024.
//

import UIKit

class TasksViewController: UIViewController {

    @IBOutlet weak var labelHeading: UILabel!
    @IBOutlet weak var tableViewTasks: UITableView!
    
    lazy var viewModel: TasksViewModel = {
        TasksViewModel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetUp()
        
        viewModel.getTasks()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.updateTasks()
        
    }
 
    @IBAction func actionBack(_ sender: Any) {
        viewModel.getDateText(dateRequired: .yesterday)
    }
    
    @IBAction func actionForward(_ sender: Any) {
        viewModel.getDateText(dateRequired: .tomorrow)
    }
    
}

// MARK: Initial Setup
extension TasksViewController {
    
    func initialSetUp() {
        
        setUpUI()
        setUpTableView()
        viewModelCallBacks()
    }
}

// MARK: UI Setup
extension TasksViewController {
    
    func setUpUI() {
        
        self.navigationController?.navigationBar.isHidden = true
        
        navigationItem.hidesBackButton = true
        self.view.backgroundColor = ColorManager.theme.value
        
        labelHeading.text = "Today"
        labelHeading.textColor = .white
    }
}

// MARK: TableView Setup
extension TasksViewController {
    
    func setUpTableView() {
        
        tableViewTasks.delegate = self
        tableViewTasks.dataSource = self
        
        tableViewTasks.estimatedRowHeight = 100
        
        tableViewTasks.register(TaskTableViewCell.nib, forCellReuseIdentifier: TaskTableViewCell.identifier)
    }
}

// MARK: ViewModel callbacks
extension TasksViewController {
    
    func viewModelCallBacks() {
        viewModelCallBacksForTableView()
        viewModelCallBacksForHeading()
        viewModelLoaderAndAlertCallBacks()
    }
    
    func viewModelCallBacksForTableView() {
        
        viewModel.reloadTableView =  { [weak self]  in
            guard let self = self else { return }
            
            tableViewTasks.reloadDataWithAutoSizingCellWorkAround()
            }
    }
    
    func viewModelCallBacksForHeading() {
        
        viewModel.updateTitle =  { [weak self]  title in
            guard let self = self else { return }
            
            labelHeading.text = title
            
            }
    }
    
    func viewModelLoaderAndAlertCallBacks() {
        
        // Show Loader
        viewModel.showLoader = { result in
            UILoaderManager.shared.showLoader(text: result)
        }
        
        // Hide Loader
        viewModel.hideLoader = {
            UILoaderManager.shared.hideLoader()
        }
    }
}

// MARK: TableView Methods
extension TasksViewController: UITableViewDelegate, UITableViewDataSource {
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let rows = viewModel.tableView(numberOfRowsInSection: section)
        
        if rows > 0 {
            self.tableViewTasks.restore()
        } else {
            self.tableViewTasks.setEmptyView()
        }
        
        return rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.identifier) as? TaskTableViewCell else { return UITableViewCell() }
        
        cell.cellViewModel = viewModel.getCellViewModel(at: indexPath)
        cell.viewBackground.backgroundColor = .white
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = TaskDetailViewController(viewModel: TaskDetailViewModel(task: viewModel.getCellViewModel(at: indexPath)), nibName: TaskDetailViewController.identifier, bundle: Bundle.main)
       navigationController?.pushViewController(vc, animated: false)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return UITableView.automaticDimension
    }
    
}

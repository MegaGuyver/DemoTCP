//
//  TaskDetailViewController.swift
//  Demo
//
//  Created by khawaja fahad on 08/06/2024.
//

import UIKit

class TaskDetailViewController: UIViewController {
    
    
    @IBOutlet weak var labelTaskTitle: UILabel!
    @IBOutlet weak var viewSperatorTitle: UIView!
    
    @IBOutlet weak var labelDueDateHeading: UILabel!
    @IBOutlet weak var labelDaysLeftHeading: UILabel!
    
    @IBOutlet weak var labelDueDate: UILabel!
    @IBOutlet weak var labelDaysLeft: UILabel!
    
    @IBOutlet weak var viewSperatorDescription: UIView!
    @IBOutlet weak var textViewDescription: UITextView!
    
    let viewModel: TaskDetailViewModel
    
    init(viewModel: TaskDetailViewModel, nibName: String, bundle: Bundle) {
      self.viewModel = viewModel
      super.init(nibName: nibName, bundle: bundle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetUp()
    }
    
    @IBAction func actionBack(_ sender: Any) {
        
        self.view.endEditing(true)
        
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: Initial Setup
extension TaskDetailViewController {
    
    func initialSetUp() {
        
        setUpUI()
        updateText()
        setUpTextViewDelegate()
        viewModelCallBacks()
    }
}

// MARK: UI Setup
extension TaskDetailViewController {
    
    func setUpUI() {
        
        self.navigationController?.navigationBar.isHidden = true
        
        navigationItem.hidesBackButton = true
        self.view.backgroundColor = ColorManager.theme.value
        
        labelTaskTitle.textColor = UIColor(hexString: "#EF4B5E")
        labelTaskTitle.font = .AmsiPro(.bold, size: 30)
        
        viewSperatorTitle.backgroundColor = UIColor(hexString: "#F6EFDE")
        
        labelDueDateHeading.textColor = UIColor(hexString: "#0E7868")
        labelDueDateHeading.font = .AmsiPro(.regular, size: 15)
        
        labelDaysLeftHeading.textColor = UIColor(hexString: "#0E7868")
        labelDaysLeftHeading.font = .AmsiPro(.regular, size: 15)
        
        
        labelDueDate.textColor = UIColor(hexString: "#EF4B5E")
        labelDueDate.font = .AmsiPro(.bold, size: 20)
        
        labelDaysLeft.textColor = UIColor(hexString: "#EF4B5E")
        labelDaysLeft.font = .AmsiPro(.bold, size: 20)
        
        viewSperatorTitle.backgroundColor = UIColor(hexString: "#F6EFDE")
        
        textViewDescription.textColor = UIColor(hexString: "#EF4B5E")
        textViewDescription.font = .AmsiPro(.bold, size: 15)
        
        labelDueDateHeading.text = "Due Date"
        labelDaysLeftHeading.text = "Days Left"
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        labelDueDate.isUserInteractionEnabled = true
        labelDueDate.addGestureRecognizer(tap)
        
        textViewDescription.textContainerInset = .zero
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        
        let myDatePicker: UIDatePicker = UIDatePicker()
            myDatePicker.datePickerMode = .date
            myDatePicker.preferredDatePickerStyle = .wheels
            myDatePicker.date = viewModel.getTaskDate()
            myDatePicker.minimumDate = Date()
            myDatePicker.frame = CGRect(x: 0, y: 15, width: 270, height: 200)
        
        let alertController = UIAlertController(title: "\n\n\n\n\n\n\n", message: nil, preferredStyle: .alert)
            alertController.view.addSubview(myDatePicker)
            let selectAction = UIAlertAction(title: "OK", style: .default, handler: { [weak self]  _ in
                guard let self = self else { return }
              
                viewModel.updateTask(date: myDatePicker.date)
                
            })
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(selectAction)
            alertController.addAction(cancelAction)
        
        
            present(alertController, animated: true)
        
    }
    
    func updateText() {
        
        labelTaskTitle.text = viewModel.task.title
        
        if viewModel.task.dueDate == "" {
            
            labelDueDate.text = "Add Due Date"
            labelDaysLeft.text = ""
            
        } else {
            
            labelDueDate.text = viewModel.task.dueDate
            labelDaysLeft.text = viewModel.task.daysLeft
        }
        
        textViewDescription.text = viewModel.task.object.description
    }
}

// MARK: ViewModel callbacks
extension TaskDetailViewController {
    
    func viewModelCallBacks() {
        viewModelCallBacksForDate()
    }
    
    func viewModelCallBacksForDate() {
        
        viewModel.updateDate =  { [weak self] dueDateString, daysleftString in
            guard let self = self else { return }
            
            labelDueDate.text = dueDateString
            labelDaysLeft.text = daysleftString
        }
    }
}

// MARK: UITextView SetUp
extension TaskDetailViewController: UITextViewDelegate {
    
    func setUpTextViewDelegate() {
        textViewDescription.delegate = self
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        viewModel.updateTask(updatedescription: textView.text)
    }
}

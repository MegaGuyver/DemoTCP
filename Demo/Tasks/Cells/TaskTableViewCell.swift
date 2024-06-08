//
//  TaskTableViewCell.swift
//  Demo
//
//  Created by khawaja fahad on 07/06/2024.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var labelTaskTitle: UILabel!
 
    @IBOutlet weak var viewSperator: UIView!
    
    @IBOutlet weak var labelDueDateHeading: UILabel!
    @IBOutlet weak var labelDaysLeftHeading: UILabel!
    
    @IBOutlet weak var labelDueDate: UILabel!
    @IBOutlet weak var labelDaysLeft: UILabel!
    
    
    var cellViewModel: TaskTableViewCellViewModel? {
        didSet {
            labelTaskTitle.text = cellViewModel?.title
            labelDueDate.text = cellViewModel?.dueDate
            labelDaysLeft.text = cellViewModel?.daysLeft
            
            if labelDueDate.text == "" {
                labelDueDateHeading.text = ""
                labelDaysLeftHeading.text = ""
            } else {
                labelDueDateHeading.text = "Due Date"
                labelDaysLeftHeading.text = "Days Left"
            }
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        labelTaskTitle.sizeToFit()
        labelTaskTitle.numberOfLines = 2
        
        labelTaskTitle.textColor = UIColor(hexString: "#EF4B5E")
        labelTaskTitle.font = .AmsiPro(.bold, size: 15)
        
        viewSperator.backgroundColor = UIColor(hexString: "#F6EFDE")
        
        
        labelDueDateHeading.textColor = UIColor(hexString: "#0E7868")
        labelDueDateHeading.font = .AmsiPro(.regular, size: 10)
        
        labelDaysLeftHeading.textColor = UIColor(hexString: "#0E7868")
        labelDaysLeftHeading.font = .AmsiPro(.regular, size: 10)
        
        
        labelDueDate.textColor = UIColor(hexString: "#EF4B5E")
        labelDueDate.font = .AmsiPro(.bold, size: 15)
        
        labelDaysLeft.textColor = UIColor(hexString: "#EF4B5E")
        labelDaysLeft.font = .AmsiPro(.bold, size: 15)
        
        backgroundColor = .clear
        selectionStyle = .none
        
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.setNeedsUpdateConstraints()
        
        viewBackground.roundCorners(radius: 5)
        
    }
    
}

extension UIView {
    func roundTopCorners(radius: CGFloat = 20.0) {
        let bounds = self.bounds
        let rect = CGRect(x: bounds.minX, y: bounds.minY, width: bounds.width, height: bounds.height)
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat, rect: CGRect) {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func roundCorners(corners: UIRectCorner = [.allCorners], radius: CGFloat = 20.0) {
        let bounds = self.bounds
        let rect = CGRect(x: bounds.minX, y: bounds.minY, width: bounds.width, height: bounds.height)
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
}

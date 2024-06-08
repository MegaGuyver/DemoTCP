//
//  UITableView-Extensions.swift
//  Demo
//
//  Created by khawaja fahad on 07/06/2024.
//

import Foundation
import UIKit

extension UITableView {

    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .none
    }
}

extension UITableView {
    func reloadDataWithAutoSizingCellWorkAround() {
        self.reloadData()
        self.setNeedsLayout()
        self.layoutIfNeeded()
        self.reloadData()
    }
}

extension UITableView {

    func setEmptyView(_ message: String = "No Task for Today") {
        
        self.setNeedsDisplay()
        
        let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width - 32, height: self.bounds.size.width - 32))
        
        let imageView = UIImageView(frame: CGRect(x: 16, y: 16, width: containerView.bounds.size.width - 64, height: containerView.bounds.size.width - 64))
        imageView.image = UIImage(named: "empty_screen")
        
        imageView.center = CGPoint(x: containerView.bounds.size.width  / 2,
                                     y: containerView.bounds.size.height / 2 - 32)
        
        let labelNotFound = UILabel(frame: CGRect(x: 0, y: imageView.bounds.size.height + 16, width: containerView.bounds.width, height: 35))
        labelNotFound.text = message
        labelNotFound.adjustsFontSizeToFitWidth = true
        labelNotFound.textColor = .white
        labelNotFound.numberOfLines = 1
        labelNotFound.textAlignment = .center
        labelNotFound.font = .AmsiPro(.bold, size: 24)
        
        
        containerView.addSubview(imageView)
        containerView.addSubview(labelNotFound)
        
        backgroundView.addSubview(containerView)
        
        containerView.center = CGPoint(x: backgroundView.bounds.size.width  / 2,
                                     y: backgroundView.bounds.size.height / 2)
   
        self.backgroundView = backgroundView
        self.separatorStyle = .none
    }

}



extension UITableView {
    func showActivityIndicator() {
        DispatchQueue.main.async {
            let activityView = UIActivityIndicatorView(style: .large)
            activityView.color = ColorManager.theme.value
            self.backgroundView = activityView
            activityView.startAnimating()
        }
    }

    func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.backgroundView = nil
        }
    }
}

//
//  UITableViewCell-Extensions.swift
//  Demo
//
//  Created by khawaja fahad on 07/06/2024.
//

import Foundation
import UIKit

extension UITableViewCell {
    
    static var identifier: String { return String(describing: self) }
    static var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
}

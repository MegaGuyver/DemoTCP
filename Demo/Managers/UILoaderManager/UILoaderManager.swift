//
//  UILoaderManager.swift
//  Demo
//
//  Created by khawaja fahad on 08/06/2024.
//

import ProgressHUD

class UILoaderManager {
    
    static let shared = UILoaderManager()
    
    private init() {
    }
    
    func showLoader(text: String? = nil) {
        ProgressHUD.animate(text, .horizontalDotScaling)
    }
    
    func hideLoader() {
        ProgressHUD.dismiss()
    }
    
}

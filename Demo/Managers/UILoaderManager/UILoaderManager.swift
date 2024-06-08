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
        ProgressHUD.colorHUD = .white
        ProgressHUD.colorAnimation = ColorManager.theme.value
        ProgressHUD.colorBannerMessage = ColorManager.theme.value
        ProgressHUD.colorBannerTitle = ColorManager.theme.value
    }
    
    func showLoader(text: String? = nil) {
        ProgressHUD.animate(text, .horizontalDotScaling)
    }
    
    func hideLoader() {
        ProgressHUD.dismiss()
    }
    
}

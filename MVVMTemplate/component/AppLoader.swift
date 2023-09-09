//
//  AppLoader.swift
//  MVVMTemplate
//
//  Created by Baran Güngör on 9.09.2023.
//

import Foundation
import UIKit

class CustomLoader {
    static let shared = CustomLoader()
    
    private let loaderView: UIActivityIndicatorView
    
    private init() {
        loaderView = UIActivityIndicatorView(style: .large)
        loaderView.hidesWhenStopped = true
        
        if let keyWindow = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .first(where: { $0.activationState == .foregroundActive })?
            .windows.first(where: { $0.isKeyWindow }) {
            loaderView.center = keyWindow.center
            keyWindow.addSubview(loaderView)
        }
    }
    
    func startLoading() {
        DispatchQueue.main.async {
            self.loaderView.startAnimating()
        }
    }
    
    func stopLoading() {
        DispatchQueue.main.async {
            self.loaderView.stopAnimating()
        }
    }
}

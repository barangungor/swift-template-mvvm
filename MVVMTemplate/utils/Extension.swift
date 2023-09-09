//
//  Extension.swift
//  MVVMTemplate
//
//  Created by Baran Güngör on 9.09.2023.
//

import Foundation
import UIKit

extension UIViewController {
    
    func goPage(identifier: String){
        if let view = self.storyboard?.instantiateViewController(withIdentifier: identifier) {
            self.navigationController?.pushViewController(view, animated: true)
        } else {
            return
        }
    }
    
    func listenError(viewModel: BaseViewModel) {
        viewModel.onErrorUpdated = { [weak self] errorData, actions in
            let alert: UIAlertController = GlobalComponents.instance.customAlert(title: "Uyarı!", message: errorData,
            actions: actions ?? [
             UIAlertAction(title: "Tamam", style: .default, handler: { _ in
             })])
            self?.present(alert,animated: true)
        }
    }
    
    func listenLoading(viewModel: BaseViewModel) {
        viewModel.onLoadingUpdated = { [weak self] isLoading in
            if(isLoading == true){
                self?.view.isUserInteractionEnabled = false
                self?.showLoading()
            } else {
                self?.view.isUserInteractionEnabled = true
                self?.stopLoading()
            }
        }
    }
    
    func showLoading() {
        CustomLoader.shared.startLoading()
    }
    func stopLoading() {
        CustomLoader.shared.stopLoading()
    }
    
    func hideKeyboardOnTapSpace() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func setBorder(view: UIView) {
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.gray.withAlphaComponent(0.2).cgColor
        view.layer.cornerRadius = 5
    }
    
}

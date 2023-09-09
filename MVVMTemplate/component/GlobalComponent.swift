//
//  GlobalComponent.swift
//  MVVMTemplate
//
//  Created by Baran Güngör on 9.09.2023.
//

import Foundation
import UIKit

class GlobalComponents {
    static let instance = GlobalComponents()
    private init() {}
    
    func customAlert(title: String?, message: String?, actions: [UIAlertAction?]) -> UIAlertController {
        let alert = UIAlertController(title: title ?? "Uyarı!",
                                      message: message ?? "Bir hata oluştu" ,
                                      preferredStyle: .alert)
        for action in actions {
            if(action != nil){
                alert.addAction(action!)
            }
        }
        return alert
    }
}

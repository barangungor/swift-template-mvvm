//
//  BaseViewModel.swift
//  MVVMTemplate
//
//  Created by Baran Güngör on 9.09.2023.
//

import Foundation
import UIKit

class BaseViewModel {
    static let instance = BaseViewModel()
    var isLoading: Bool = false {
        didSet {
            if(oldValue != isLoading) {
                onLoadingUpdated?(isLoading)
            }
        }
    }
    var alertActions: [UIAlertAction?]? = []
    var errorMessage: String? = nil {
        didSet {
            onErrorUpdated?(errorMessage, alertActions)
        }
    }
    var onErrorUpdated: ((String?, [UIAlertAction?]?) -> Void)?
    var onLoadingUpdated: ((Bool) -> Void)?
}

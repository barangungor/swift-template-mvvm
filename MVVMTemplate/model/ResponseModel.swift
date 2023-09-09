//
//  ResponseModel.swift
//  MVVMTemplate
//
//  Created by Baran Güngör on 9.09.2023.
//

import Foundation

struct ResponseModel<T: Codable>: Codable {
    let meta: Meta
    let success: Bool
    let data: T?
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseMeta { response in
//     if let meta = response.result.value {
//       ...
//     }
//   }

// MARK: - Meta
struct Meta: Codable {
    let requestID,errorCode, errorMessage: String?
    let httpStatusCode: Int
    let errorType: ErrorType?

    enum CodingKeys: String, CodingKey {
        case requestID = "requestId"
        case httpStatusCode, errorType, errorCode, errorMessage
    }
    
}

enum ErrorType: String, Codable {
    case internalError = "internal"
    case publicError = "public"
}

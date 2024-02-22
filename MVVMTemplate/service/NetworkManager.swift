//
//  NetworkManager.swift
//  MVVMTemplate
//
//  Created by Baran Güngör on 9.09.2023.
//
import Foundation
import Alamofire
import SwiftyJSON

struct NetworkManager{
    
    static let instance = NetworkManager()
    
    let baseAPIURL = "API URL d sa"
    
    public func fetch<T:Codable, U: Codable> (_ method: HTTPMethod, endpoint: String, requestModel: T?, model: T.Type, responseDataModel: U.Type, completion: @escaping (AFResult<Codable?>?) -> Void?) {
        let url = self.baseAPIURL + endpoint
        let urlEncoded = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        AF.request(urlEncoded!, method: method, parameters: toEncodedData(model: requestModel),encoding: JSONEncoding.default).responseData { response in
//            print(response.result)
            switch response.result {
            case .success(let value):
                do{
                    let responseJsonData = JSON(value as Any)
//                    print(responseJsonData)
                    let responseModel = try JSONDecoder().decode(ResponseModel<U>.self, from: responseJsonData.rawData())
                    completion(.success(responseModel))
                }
                catch let parseError{
                    print("Success parsing error: \(parseError)")
                    completion(parseError.asAFError != nil ? .failure(parseError.asAFError!) : .success(nil))
                }
            case .failure(let error):
                print("Failure: \(error)")
                completion(.failure(error))
            }
        }
    }
    
    func toEncodedData<T:Encodable>(model: T?) -> [String:AnyObject]?
    {
        if(model == nil)
        {
            return nil
        }
        let jsonData = try! JSONEncoder().encode(model.self)
        let parameters = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any]
        return parameters! as [String: AnyObject]
    }
}

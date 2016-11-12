//
//  DairyAPI.swift
//  DairyNutrition
//
//  Created by Osiris on 2016-11-09.
//  Copyright © 2016 Osiris. All rights reserved.
//

import Foundation
import Alamofire

private typealias JSONObject = [String : AnyObject]

final class DairyAPI {
    static let sharedInstance = DairyAPI()
    
    // Convenience method to perform a GET request on an API endpoint.
    fileprivate func get(_ endpoint: String, completion: @escaping (AnyObject?) -> Void) {
        request(endpoint, method: .get, encoding: JSONEncoding.default, parameters: nil, completion: completion)
    }
    
    // Convenience method to perform a POST request on an API endpoint.
    fileprivate func post(_ endpoint: String, parameters: [String: AnyObject]?, completion: @escaping (AnyObject?) -> Void) {
        request(endpoint, method: .post, encoding: JSONEncoding.default, parameters: parameters, completion: completion)
    }
    
    // Perform a request on an API endpoint using Alamofire.
    fileprivate func request(_ endpoint: String, method: HTTPMethod, encoding: Alamofire.ParameterEncoding, parameters: [String: AnyObject]?, completion: @escaping (AnyObject?) -> Void) {
        
        //let request = encoding.encode(URLRequest as! URLRequestConvertible, with: parameters).0
        
        print("Starting \(method) \(apiBaseURL + endpoint) (\(parameters ?? [:]))")
        Alamofire.request(apiBaseURL + endpoint, method: method, parameters: parameters, encoding: encoding)
            .responseJSON { response in
            
            //print(response.request!)  // original URL request
            print(response.result)   // result of response serialization
            
            switch response.result {
            case .success(let JSON):
                completion(JSON as AnyObject?)
            case .failure(let error):

                if Reachability.isConnectedToNetwork() == false {
                    print("Device isn't connected to network")
                    
                } else {
                    print("Request failed with error: \(error)")
                }
                completion(nil)
            }
        }
    }
}

final class AuthenticatedDairyAPI {
    
    func registerUser(_ digitsUserID: String?, digitsPhoneNumber: String?, completion: @escaping (Bool) -> ()) {
        var parameters: JSONObject = ["cognitoId": "test" as AnyObject]
        if let digitsUserID = digitsUserID, let digitsPhoneNumber = digitsPhoneNumber {
            parameters["digitsId"] = digitsUserID as AnyObject?
            parameters["phoneNumber"] = digitsPhoneNumber as AnyObject?
        }
        
        DairyAPI.sharedInstance.post("users/", parameters: parameters) { response in
            let success = response != nil
            
            completion(success)
        }
    }
    
    func loginUser(_ email: String?, password: String?, completion: @escaping (_ user: User?) -> ()) {
        var parameters: JSONObject = ["password": password as AnyObject]
        parameters["email"] = email as AnyObject?
        
        DairyAPI.sharedInstance.post("login/", parameters: parameters) { response in
            
            guard let result = response as? JSONObject,
                let user = result["user"] as? [JSONObject] else {
                    completion(nil)
                    return
            }
            
//            var user = User()
            
            
            
//            if let result = JSON as? JSONObject {
//                var user = User()
//                let msg = result["message"] as! String
//                let userArray = result["user"] as! [JSONObject]
//                for userDict in userArray {
//                    user = User(dictionary: userDict)
//                }
//                completion(user, msg)
//            }
        }
    }
        
    func demo(completion: @escaping (Bool) -> ()) {
        var parameters: JSONObject = ["format": "json" as AnyObject]
        parameters["lt"] = "f" as AnyObject?
        parameters["max"] = "500" as AnyObject?
        parameters["offset"] = "0" as AnyObject?
        parameters["sort"] = "id" as AnyObject?
        parameters["api_key"] = "F1aPLDn8zX7K0TRlxboPlODCxW8FUZZdbCYTPWD7" as AnyObject?

        DairyAPI.sharedInstance.post("sayhello/", parameters: parameters) { response in
            let success = response != nil
            
            completion(success)
        }
    }
}

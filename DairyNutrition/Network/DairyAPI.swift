//
//  DairyAPI.swift
//  DairyNutrition
//
//  Created by Osiris on 2016-11-09.
//  Copyright © 2016 Osiris. All rights reserved.
//

import Foundation
import Alamofire

public typealias JSONObject = [String : AnyObject]

final class DairyAPI {
    static let sharedInstance: DairyAPI = DairyAPI()
    
    // Convenience method to perform a GET request on an API endpoint.
    public func get(_ endpoint: String, parameters: [String: AnyObject]?, success: @escaping (AnyObject) -> Void, failure: @escaping (NSError) -> Void) {
        request(endpoint, method: .get, encoding: JSONEncoding.default, parameters: parameters, success: success, failure: failure)
    }
    
    // Convenience method to perform a POST request on an API endpoint.
    public func post(_ endpoint: String, parameters: [String: AnyObject]?, success: @escaping (AnyObject) -> Void, failure: @escaping (NSError) -> Void) {
        request(endpoint, method: .post, encoding: JSONEncoding.default, parameters: parameters, success: success, failure: failure)
    }
    
    // Perform a request on an API endpoint using Alamofire.
    fileprivate func request(_ endpoint: String, method: HTTPMethod, encoding: Alamofire.ParameterEncoding, parameters: [String: AnyObject]?,
                      success: @escaping (AnyObject) -> Void, failure: @escaping (NSError) -> Void) {
        var path = ""
        
        if endpoint == "nutrients" {
            path = foodApiBaseURL + endpoint + "/?api_key=" + foodApiKey
        } else {
            path = apiBaseURL + endpoint
        }
        
        print("Starting \(method) \(path) (\(parameters ?? [:]))")
        Alamofire.request(path, method: method, parameters: parameters, encoding: encoding)
            .responseJSON { response in
                
            switch response.result {
            case .success(let JSON):
                success(JSON as AnyObject)
            case .failure(let error):
                
                if Reachability.isConnectedToNetwork() == false {
                    print("Device isn't connected to network")
                    self.postNotification()
                } else {
                    print("Request failed with error: \(error)")
                }
                failure(error as NSError)
            }
        }
    }
    
    private func postNotification() {
        NotificationCenter.default.post(name: Notification.Name.noNetworkConnection, object: nil)
    }
}

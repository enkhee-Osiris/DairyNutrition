//
//  ProfileService.swift
//  DairyNutrition
//
//  Created by Osiris on 2016-11-13.
//  Copyright © 2016 Osiris. All rights reserved.
//

import Foundation

public struct UserService {
    public init() {}
    
    func loginUser(_ email: String?, password: String?, completion: @escaping (_ user: User?) -> ()) {
        var parameters: JSONObject = ["password": password as AnyObject]
        parameters["email"] = email as AnyObject?
        
        DairyAPI.sharedInstance.post("login/", parameters: parameters,
            success: { json in
                
                do {
                    let data1 =  try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted) // first of all convert json to the data
                    let convertedString: String = String(data: data1, encoding: String.Encoding.utf8)! // the data will be converted to the string
                    print(convertedString) // <-- here is ur string
                    
                } catch let myJSONError {
                    print(myJSONError)
                }
                completion(User(fromJson: json))
        },
            failure: { error in
                completion(nil)
        })
    }
}

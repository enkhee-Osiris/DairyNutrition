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
    
    func loginUser(_ email: String, password: String, completion: @escaping (_ user: User?) -> ()) {
        var parameters: JSONObject = ["password": password as AnyObject]
        parameters["email"] = email as AnyObject
        
        DairyAPI.sharedInstance.post("login/", parameters: parameters,
            success: { json in
                
                do {
                    let data =  try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted)
                    // first of all convert json to the data
                    let convertedString: String = String(data: data, encoding: String.Encoding.utf8)!
                    // the data will be converted to the string
                    print(convertedString)
                    
                } catch let error {
                    print(error)
                }
                completion(User(fromJson: json))
            },
            failure: { error in
                completion(nil)
            }
        )
    }
    
    func registerUser(user: User, password: String, completion: @escaping (_ success: Bool) -> ()) {
        var parameters: JSONObject = ["password": password as AnyObject]
        parameters["email"] = user.email as AnyObject
        parameters["lastName"] = user.fullName as AnyObject
        parameters["firstName"] = user.fullName as AnyObject
        parameters["weightGoalType"] = user.weightGoalType?.rawValue as AnyObject
        parameters["weightGoal"] = user.weightGoal as AnyObject
        parameters["weightGoalUnit"] = user.weightGoalUnit?.rawValue as AnyObject
        parameters["gender"] = user.gender?.rawValue as AnyObject
        parameters["activityLevel"] = user.activityLevel?.rawValue as AnyObject
        parameters["weight"] = user.weight as AnyObject
        parameters["weightUnit"] = user.weightUnit as AnyObject
        parameters["height"] = user.height as AnyObject
        parameters["heightUnit"] = user.heightUnit?.rawValue as AnyObject
        parameters["dateOfBirth"] = user.dob as AnyObject
        
        DairyAPI.sharedInstance.post("register/", parameters: parameters,
             success: { json in
                
                do {
                    let data =  try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted)
                    // first of all convert json to the data
                    let convertedString: String = String(data: data, encoding: String.Encoding.utf8)!
                    // the data will be converted to the string
                    print(convertedString)
                    
                } catch let error {
                    print(error)
                }
                completion(true)
                
            }, failure: { error in
                completion(false)
            }
        )
    }
}

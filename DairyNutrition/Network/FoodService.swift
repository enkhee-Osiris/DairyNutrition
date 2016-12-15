//
//  NutritionService.swift
//  DairyNutrition
//
//  Created by Osiris on 2016-12-15.
//  Copyright © 2016 Osiris. All rights reserved.
//

import Foundation

public struct FoodService {
    public init() {}

    func getFood(id: Int,  completion: @escaping (_ user: Food?) -> ()) {
        var parameters: JSONObject = ["nutrients": ["204","205","203","208"] as AnyObject]
        parameters["ndbno"] = id as AnyObject
        parameters["max"] = 500 as AnyObject
        parameters["offset"] = 0 as AnyObject

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
                completion(Food(fromJson: json))
            },
            failure: { error in
                completion(nil)
            }
        )

        
    }
}

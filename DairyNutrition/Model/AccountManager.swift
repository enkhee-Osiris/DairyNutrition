////
////  AccountManager.swift
////  DairyNutrition
////
////  Created by Osiris on 2016-11-09.
////  Copyright © 2016 Osiris. All rights reserved.
////
//
//import Foundation
//import SwiftyUserDefaults
//
//final class AccountManager {
//    
////    static var defaultAccountManager = AccountManager()
//    
//    var isUserLoggedIn: Bool = Defaults[.loggedIn] ?? false
//    
//    var user: User? = Defaults[.loggedUser]
//    var authenticatedAPI = AuthenticatedDairyAPI()
//    
//    //func authenticateWithService(_ service: Service, completion: @escaping (_ success: Bool) -> ()) {
//    //    switch service {
//    //    case .Twitter: self.authenticateWithTwitter(completion: completion)
//    //    case .Digits: self.authenticateWithDigits(completion: completion)
//    //    }
//    //}
//    
//    func login(email: String, password: String, completion: @escaping (_ success: Bool) -> ()) {
//        //print(self.user)
//        authenticatedAPI.loginUser(email, password: password) { user in
//            //print(user?.fullName)
//            if user != nil {
//                self.isUserLoggedIn = true
//                //setting userLogged into UserDefaults
//                Defaults[.loggedIn] = true
//                
//                self.updateUser(user: user!)
//                completion(true)
//            }
//            completion(false)
//        }
//        
//        //authenticatedAPI?.loginUser(email, password: password, completion: { response in
//        //    if response != nil {
//        //        completion(true, response as! NSDictionary<String, AnyObject>)
//        //    }
//        //})
//    }
//    
//    
//    func signOut() {
//        self.user = nil
////        Defaults[.user] = self.user
//        
//        self.isUserLoggedIn = false
//        Defaults[.loggedIn] = false
//    }
//    
//    fileprivate func updateUser(user: User) {
//        guard self.isUserLoggedIn else {
//            self.user = nil
//            return
//        }
//        
//        self.user = user
//        Defaults[.loggedUser] = self.user
//    }
//}

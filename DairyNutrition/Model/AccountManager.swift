//
//  AccountManager.swift
//  DairyNutrition
//
//  Created by Osiris on 2016-11-09.
//  Copyright © 2016 Osiris. All rights reserved.
//

import Foundation

final class AccountManager {
    static func setAccountManager(_ accountManager: AccountManager) {
        defaultAccountManager = accountManager
    }
    
    static var defaultAccountManager: AccountManager!
    
    var isUserLoggedIn: Bool = false
    
    var user: User?

    var authenticatedAPI: AuthenticatedDairyAPI?
    
    //func authenticateWithService(_ service: Service, completion: @escaping (_ success: Bool) -> ()) {
    //    switch service {
    //    case .Twitter: self.authenticateWithTwitter(completion: completion)
    //    case .Digits: self.authenticateWithDigits(completion: completion)
    //    }
    //}
    
//    func login(_ email: String, password: String, _ completion: @escaping (_ success: Bool, _ response: NSDictionary?) -> ()) {
//        authenticatedAPI?.loginUser(email, password: password, completion: { response in
//            if response != nil {
//                completion(true, response as! NSDictionary<String, AnyObject>)
//            }
//        })
//        self.isUserLoggedIn = true
//    }
    
    
    func signOut() {
//        if self.digitsIdentity != nil {
//            Digits.sharedInstance().logOut()
//        }
//        
//        if let twitterSession = self.twitterIdentity {
//            Twitter.sharedInstance().sessionStore.logOutUserID(twitterSession.userID)
//        }
        
        self.user = nil
        self.authenticatedAPI = nil
        
        self.isUserLoggedIn = false
    }
    
    fileprivate func updateUser() {
        guard self.isUserLoggedIn else {
            self.user = nil
            return
        }
        
        let user = User()
        //user.twitterUserID = self.twitterIdentity?.userID
        //user.twitterUsername = self.twitterIdentity?.userName
        //user.digitsUserID = self.digitsIdentity?.userID
        //user.digitsPhoneNumber = self.digitsIdentity?.phoneNumber
        //user.cognitoID = self.cognitoID
        
        //user.populateWithLocalContact()
        
        self.user = user
    }

}

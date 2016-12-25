//
//  MenuTableViewController.swift
//  DairyNutrition
//
//  Created by Osiris on 2016-12-07.
//  Copyright © 2016 Osiris. All rights reserved.
//

import UIKit
import KYDrawerController
import SwiftyUserDefaults

class MenuTableViewController: UITableViewController {
    
    // MARK: Properties
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var userEmailLabel: UILabel!
    
    @IBOutlet weak var userAvatarImageView: UIImageView!
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        
        
        userNameLabel.text = Shared.shared.currentUser.fullName
        
        userEmailLabel.text = Shared.shared.currentUser.email
        
        if Shared.shared.currentUser.gender == UserGender.male {
            userAvatarImageView.image = UIImage(named: "male-icon")?.resizeWithHeight(60)
        } else {
            userAvatarImageView.image = UIImage(named: "female-icon")?.resizeWithHeight(60)
        }
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let index = indexPath as NSIndexPath
        let row = index.row
        
        switch row {
        case 0:
            return
        case 1:
            if let drawerController = parent as? KYDrawerController {
                drawerController.setDrawerState(.closed, animated: true)
            }
        case 2:
            NotificationCenter.default.post(name: Notification.Name.pushFoodDairy, object: nil)
        case 3:
            // Exercise dairy
            NotificationCenter.default.post(name: Notification.Name.pushExerciseDairy, object: nil)
        case 4:
            // weight Tracker
            NotificationCenter.default.post(name: Notification.Name.pushWeightTracker, object: nil)
        case 5:
            // Settings
            NotificationCenter.default.post(name: Notification.Name.pushSettings, object: nil)
        default:
            Defaults[.loggedIn] = false
            super.presentVC((UIStoryboard.mainStoryboard?.instantiateVC(WelcomeViewController.self))!)
        }
    }
}

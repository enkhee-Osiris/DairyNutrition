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
        
        switch indexPath.row {
        case 1:
            if let drawerController = parent as? KYDrawerController {
                drawerController.setDrawerState(.closed, animated: true)
            }
        case 2:
            // Food dairy
            print("Food dairy")
        case 3:
            // Exercise dairy
            print("Exercise")
        case 4:
            // weight Tracker
            print("Weight tracker")
            
        case 5:
            // Settings
            print("settings")
        default:
            Defaults[.loggedIn] = false
            super.presentVC((UIStoryboard.mainStoryboard?.instantiateVC(WelcomeViewController.self))!)
        }
    }
}

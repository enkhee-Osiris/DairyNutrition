//
//  WelcomeViewController.swift
//  DairyNutrition
//
//  Created by Osiris on 2016-11-06.
//  Copyright © 2016 Osiris. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import SwiftyUserDefaults

class WelcomeViewController : MainViewController {

    // MARK: Properties
    
    var player: AVPlayer?
    
    let videoURL: URL = Bundle.main.url(forResource: "moments", withExtension: "mp4")!
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupVideoBackground()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.player?.play()
        super.addNotificationObserver(NSNotification.Name.AVPlayerItemDidPlayToEndTime.rawValue, selector: #selector(self.loopVideo))
        
        if let logged = Defaults[.loggedIn] {
            if logged == true {
                Shared.shared.currentUser = Defaults[.loggedUser]
                self.player?.pause()
                super.removeNotificationObserver()
                
                super.presentVC((UIStoryboard.mainStoryboard?.instantiateViewController(withIdentifier: "BaseViewController"))!)
            }
        }
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        self.player?.pause()
        super.removeNotificationObserver()
    }
    
    // MARK: Utilities
    
    func setupVideoBackground() {
        self.player = AVPlayer(url: videoURL)
        self.player?.actionAtItemEnd = .none
        self.player?.isMuted = true
        
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        playerLayer.zPosition = -1
        playerLayer.frame = view.frame
        
        // Adding player layer to view as sublayer
        view.layer.addSublayer(playerLayer)
        
        // Starts playing
        self.player?.play()
        
        //loop video
        super.addNotificationObserver(NSNotification.Name.AVPlayerItemDidPlayToEndTime.rawValue, selector: #selector(self.loopVideo))
    }
    
    func loopVideo() {
        self.player?.seek(to: kCMTimeZero)
        self.player?.play()
    }

}

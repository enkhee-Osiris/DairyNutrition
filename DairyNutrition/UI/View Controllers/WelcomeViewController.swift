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

class WelcomeViewController : MainViewController {

    var player: AVPlayer?
    let videoURL: URL = Bundle.main.url(forResource: "moments", withExtension: "mp4")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupVideoBackground()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        player?.play()
        addNotificationObserver(NSNotification.Name.AVPlayerItemDidPlayToEndTime.rawValue, selector: #selector(self.loopVideo))
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        player?.pause()
        removeNotificationObserver()
    }
    
    func setupVideoBackground() {
        player = AVPlayer(url: videoURL)
        player?.actionAtItemEnd = .none
        player?.isMuted = true
        
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        playerLayer.zPosition = -1
        
        playerLayer.frame = view.frame
        
        view.layer.addSublayer(playerLayer)
        
        player?.play()
        
        //loop video
        addNotificationObserver(NSNotification.Name.AVPlayerItemDidPlayToEndTime.rawValue, selector: #selector(self.loopVideo))
    }
    
    func loopVideo() {
        player?.seek(to: kCMTimeZero)
        player?.play()
    }

}

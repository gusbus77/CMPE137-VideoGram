//
//  VideoFeedController.swift
//  Project Group 4
//
//  Created by student on 11/11/18.
//  Copyright © 2018 The WIndow Specialists. All rights reserved.
//

import Foundation
import UIKit
import AVKit
import AVFoundation


class VideoFeedController: UIViewController{
    
    var videos: [Video] = UploadVideo().loadVideo()
    var player = AVPlayer()
    var playerViewController = AVPlayerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //self.feedTableView.dataSource = self , need to include UITableViewDataSource
        //self.feedTableView.delegate   = self , need to include UITableViewDelegate
    }
    
    @IBOutlet weak var feedTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCell") as! FeedTableViewCell
        
        let videoFile = videos[indexPath.row]
        cell.video = videoFile
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView.deselectRow(at: <#T##IndexPath#>, animated: true)
        playSelectedVideo(at: indexPath)
    }
    
    func playSelectedVideo(at indexPath: IndexPath) {
//        let videoToPlay = videos[indexPath.row]
//        let vidPath = Bundle.main.path(forResource: videoToPlay.videoName, ofType: "mp4")
//        player = AVPlayer(url: URL)
//        playerViewController.player = player
//
//        self.present(playerViewController, animated: true, completion: {
//            self.playerViewController.player?.play()
//        })
    }
    
} //end of VideoFeedController

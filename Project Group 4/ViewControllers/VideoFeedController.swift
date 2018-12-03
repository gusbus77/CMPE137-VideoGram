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
import FBSDKLoginKit


class VideoFeedController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var videos: [Video] = UploadVideo.CKVideo.loadPublicVideos()
    var player = AVPlayer()
    var playerViewController = AVPlayerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.feedTableView.dataSource = self
        self.feedTableView.delegate   = self
    }
    
    @IBOutlet weak var feedTableView: UITableView!
    
    //UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCell") as! FeedTableViewCell
        
        let videoFile = videos[indexPath.row]
        cell.video = videoFile
        return cell
    }
    
    //UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        playSelectedVideo(at: indexPath)
    }

    func playSelectedVideo(at indexPath: IndexPath) {
        let videoToPlay = videos[indexPath.row]
        //Get CKAsset Data as fileurl
        let videoData = videoToPlay.videoData
        let videoURL  = videoData?.fileURL
        player = AVPlayer(url: videoURL!)
        playerViewController.player = player

        self.present(playerViewController, animated: true, completion: {
            self.playerViewController.player?.play()
        })
    }
    
    @IBAction func logOut(_ sender: UIButton) {
        print("logout works")
        self.logOut()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "profileLogOut3") {
            print("PREPARE FUNCTION TRIGGERED IN ALBUM CONTROLLER")
            FBSDKLoginManager().logOut()
        }
    }
    
    func logOut() {
        FBSDKLoginManager().logOut()
        print("logout works again")
        performSegue(withIdentifier: "ToLogInPage", sender: nil)
        //self.navigationController?.popToRootViewController(animated: true)
    }
    
} //end of VideoFeedController

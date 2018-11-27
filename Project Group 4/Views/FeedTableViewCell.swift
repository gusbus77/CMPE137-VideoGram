//
//  FeedTableViewCell.swift
//  Project Group 4
//
//  Created by student on 11/18/18.
//  Copyright © 2018 The WIndow Specialists. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

class FeedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var videoDescriptionLabel: UILabel!
    
    var video: Video! {
        didSet {
            updateTableViewCell()
        }
    }
    
    func updateTableViewCell() {
//        thumbnailImageView.image = UIImage(named: video.videoThumbnail)
        thumbnailImageView.layer.cornerRadius = 8.0
        thumbnailImageView.layer.masksToBounds = true
        
        usernameLabel.text = video.username
        videoDescriptionLabel.text = video.videoDescription
    }
}



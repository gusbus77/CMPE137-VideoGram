//
//  FeedTableViewCell.swift
//  Project Group 4
//
//  Created by student on 11/18/18.
//  Copyright © 2018 The WIndow Specialists. All rights reserved.
//

import Foundation
import UIKit
import CloudKit

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
        let videoThumb = video.videoImg
        let thumbnailImage = videoThumb?.getImage()
        thumbnailImageView.image = thumbnailImage
        thumbnailImageView.layer.cornerRadius = 8.0
        thumbnailImageView.layer.masksToBounds = true
        
        usernameLabel.text = video.username
        videoDescriptionLabel.text = video.videoDescription
    }
}

extension CKAsset {
    func getImage() -> UIImage? {
        if let data = NSData(contentsOf: self.fileURL) {
            return UIImage(data: data as Data)
        }
        return nil
    }
}




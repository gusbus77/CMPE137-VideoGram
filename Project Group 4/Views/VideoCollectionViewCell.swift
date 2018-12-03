//
//  VideoCollectionViewCell.swift
//  Project Group 4
//
//  Created by MinJoung Kim on 11/28/18.
//  Copyright © 2018 The WIndow Specialists. All rights reserved.
//

import UIKit

class VideoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var videoImageView: UIImageView!
    
    var video: Video! {
        didSet{
            let videoImage = video.videoImg
            let videoThumnailImage = videoImage?.getImage()
            videoImageView.image = videoThumnailImage
        }
    }
    
}

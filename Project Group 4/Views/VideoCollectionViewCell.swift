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
    
    var imageName: String! {
        didSet{
            videoImageView.image = UIImage(named: imageName)
        }
    }
    
}

//
//  HeaderView.swift
//  Project Group 4
//
//  Created by MinJoung Kim on 11/28/18.
//  Copyright © 2018 The WIndow Specialists. All rights reserved.
//

import UIKit

class HeaderView: UICollectionReusableView {
    
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    var photoCategory: PhotoCategory! {
        didSet {
            categoryLabel.text = photoCategory.title
            categoryImageView.image = UIImage(named: photoCategory.categoryImageName)
        }
    }
        
}

//
//  AlbumVideo.swift
//  Project Group 4
//
//  Created by MinJoung Kim on 11/28/18.
//  Copyright © 2018 The WIndow Specialists. All rights reserved.
//

import Foundation

struct PhotoCategory {
    
    var categoryImageName: String
    var title: String
    var imageNames: [String]
    
    
    static func fetchPhotos() -> [PhotoCategory] {
        var categories = [PhotoCategory]()
        let photosData = PhotosLibrary.downloadPhotosData()
        
        for (categoryName, dict) in photosData {
            if let dict = dict as? [String : Any] {
                let categoryImageName = dict["categoryImageName"] as! String
                if let imageNames = dict["imageNames"] as? [String] {
                    let newCategory = PhotoCategory(categoryImageName: categoryImageName, title: categoryName, imageNames: imageNames)
                    categories.append(newCategory)
                }
            }
        }
        
        return categories
    }
}


class PhotosLibrary {
    
    
    
    class func downloadPhotosData() -> [String : Any]
    {
        return [
            
            "Foods" : [
                "categoryImageName" : "foods",
                "imageNames" : PhotosLibrary.generateImage(categoryPrefix: "fo", numberOfImages: 8),
            ],
            
            "Nature" : [
                "categoryImageName" : "nature",
                "imageNames" : PhotosLibrary.generateImage(categoryPrefix: "n", numberOfImages: 9),
            ]
        ]
    }
    
    private class func generateImage(categoryPrefix: String, numberOfImages: Int) ->[String]
    {
        var imageNames = [String]()
        
        for i in 1...numberOfImages {
            imageNames.append("\(categoryPrefix)\(i)")
        }
        return imageNames
    }
}

//
//  AlbumController.swift
//  Project Group 4
//
//  Created by MinJoung Kim on 11/28/18.
//  Copyright © 2018 The WIndow Specialists. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class AlbumController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var albumCollectionView: UICollectionView!
    
    @IBAction func logOut(_ sender: UIButton) {
        print("logout works")
        self.logOut()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "profileLogOut2") {
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
    
    var photoCategories: [PhotoCategory] = PhotoCategory.fetchPhotos()
    
    struct Storyboard {
        static let videoCell = "VideoCell"
        static let sectionHeaderView = "SectionHeaderView"
        static let leftAndRightPaddings : CGFloat = 2.0
        static let numberOfItemsPerRow: CGFloat = 3.0
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        let itemSize = UIScreen.main.bounds.width/3 - 3
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(20, 0, 10, 0)
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        layout.minimumInteritemSpacing = 3
        layout.minimumLineSpacing = 3
        
        albumCollectionView.collectionViewLayout = layout
    }
    

     func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return photoCategories.count
    }
    
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return photoCategories[section].imageNames.count
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.videoCell, for: indexPath) as! VideoCollectionViewCell
        
        let photoCategory = photoCategories[indexPath.section]
        let imageNames = photoCategory.imageNames
        let imageName = imageNames[indexPath.item]
        
        cell.imageName = imageName
        
        return cell
    }
    
    // For sectionHeaderView.
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let sectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Storyboard.sectionHeaderView, for: indexPath) as! HeaderView
        
        let category = photoCategories[indexPath.section]
        sectionHeaderView.photoCategory = category
        
        return sectionHeaderView
    }

}

//
//  HomePageController.swift
//  Project Group 4
//
//  Created by student on 11/11/18.
//  Copyright © 2018 The WIndow Specialists. All rights reserved.
//

import Foundation
import UIKit
import FBSDKLoginKit

class HomePageController: UIViewController {
    
    var currentUser:String = ""
    var currentUserPicture:String = ""
    var currentUserName:String = ""
    @IBOutlet weak var nameLabel: UILabel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("printing current user on home page controller")
        print(currentUser)
        nameLabel?.text = "Welcome " + currentUserName
    }
    
    @IBOutlet var albums: UIButton!
    
    @IBOutlet var shareVideo: UIButton!
    
    @IBAction func logOut(_ sender: UIButton) {
        print("logout works")
        self.logOut()
    }
    
    
    @IBAction func goToAlbums(_ sender: UIButton) {
        self.goToAlbum()
    }
    @IBAction func goToProfile(_ sender: UIButton) {
        self.goToProfile()
    }
    @IBAction func goToFeed(_ sender: UIButton) {
        self.goToFeed()
    }
    
    @IBAction func goToUpload(_ sender: UIButton) {
        self.goToUpload()
    }
    
    
    func logOut() {
        FBSDKLoginManager().logOut()
        print("logout works again")
        performSegue(withIdentifier: "ToLogInPage", sender: nil)
        //self.navigationController?.popToRootViewController(animated: true)
    }
    func goToAlbum() {
        performSegue(withIdentifier: "GoToAlbums", sender: nil)
    }
    func goToProfile() {
        performSegue(withIdentifier: "GoToProfile", sender: nil)
    }
    func goToFeed() {
        performSegue(withIdentifier: "GoToFeed", sender: nil)
    }
    func goToUpload() {
        performSegue(withIdentifier: "GoToUpload", sender: nil)
    }
    

}

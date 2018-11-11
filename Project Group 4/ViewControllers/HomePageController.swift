//
//  HomePageController.swift
//  Project Group 4
//
//  Created by student on 11/11/18.
//  Copyright © 2018 The WIndow Specialists. All rights reserved.
//

import Foundation
import UIKit

class HomePageController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet var albums: UIButton!
    
    @IBOutlet var shareVideo: UIButton!
    
    @IBAction func logOut(_ sender: UIButton) {
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
        performSegue(withIdentifier: "ToLogInPage", sender: nil)
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

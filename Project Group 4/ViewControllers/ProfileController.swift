//
//  ProfileController.swift
//  Project Group 4
//
//  Created by student on 11/11/18.
//  Copyright © 2018 The WIndow Specialists. All rights reserved.
//

import Foundation
import UIKit
import FBSDKLoginKit

class ProfileController: UIViewController {
    var currentUser:String = ""
    var currentUserPicture:String = ""
    var currentUserName:String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("printing current user on home page controller")
        print(currentUser)
       // nameLabel?.text = "Welcome " + currentUserName
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "profileLogOut") {
            print("PREPARE FUNCTION TRIGGERED IN PROFILE CONTROLLER")
            FBSDKLoginManager().logOut()
        }
    }
    @IBAction func logOut(_ sender: UIButton) {
        print("logout works")
        self.logOut()
    }
    
    func logOut() {
        FBSDKLoginManager().logOut()
        print("logout works again")
        performSegue(withIdentifier: "ToLogInPage", sender: nil)
        //self.navigationController?.popToRootViewController(animated: true)
    }
}

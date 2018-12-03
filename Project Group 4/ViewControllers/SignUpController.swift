//
//  SignUpController.swift
//  Project Group 4
//
//  Created by student on 11/11/18.
//  Copyright © 2018 The WIndow Specialists. All rights reserved.
//

import UIKit

class SignUpController: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    func popUpNotification(title: String, message: String) {
        let popup = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        popup.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(popup, animated: true, completion:nil)
    }
    
    let Error = "Error"
    let UserNameAlreadyExists = "Username Already Exists"
    let CreatedAccount = "Created Account"
    let NewAccountSignIn = "Please log in."
    let CloudConnectionError = "Sign into iCloud First"
     
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var BackButton: UIButton!
    
    @IBOutlet var usernameTextField: UITextField! {
        didSet{
            textFieldNoEditing(usernameTextField)
        }
    }
    @IBOutlet var passwordTextField: UITextField! {
        didSet{
            textFieldNoEditing(passwordTextField)
        }
    }
    
    func goToLoginPage() {
        performSegue(withIdentifier: "SignupToLogin", sender: nil)
    }
    @IBAction func GoBackToLoginPage(_ sender: Any) {
        self.goToLoginPage()
    }
    @IBAction func CreateAccountAction(_ sender: Any) {
        let usernameInput = usernameTextField.text!
        let passwordInput = passwordTextField.text!
        
        if UserBase.CKUsers.testCKConnection() {
            //Check if Username is Taken
            if UserBase.CKUsers.verifyUser(username: usernameInput) == .UsernameDoesNotExist {
                UserBase.CKUsers.addUser(username: usernameInput, password: passwordInput)
                //Popup notification - Account is created, try logging in now
                popUpNotification(title: CreatedAccount, message: NewAccountSignIn)
                UserBase.CKUsers.saveUserBase()
                
                //Segue back to Log In Page
                self.goToLoginPage()
            }
            else {
                //Popup notification - Username already exists
                popUpNotification(title: Error, message: UserNameAlreadyExists)
            }
        }
        else {
            //Popup notification - not connected to cloud server
            popUpNotification(title: Error, message: CloudConnectionError)
        }
    }

    
    func textFieldNoEditing(_ textfield: UITextField) {
        textfield.autocorrectionType = .no
        textfield.autocapitalizationType = .none
        textfield.spellCheckingType = .no
    }
}



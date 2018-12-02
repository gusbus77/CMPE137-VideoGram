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
    @IBOutlet var emailTextField: UITextField! {
        didSet{
            textFieldNoEditing(emailTextField)
        }
    }
    
    func goToLogInPageFromSignUp() {
        performSegue(withIdentifier: "SignupToLogin", sender: nil)
        print("other function")
    }
    @IBAction func GoBackToLoginPage(_ sender: Any) {
        self.goToLogInPageFromSignUp()
    }
    @IBAction func CreateAccountAction(_ sender: Any) {
        let usernameInput = usernameTextField.text!
        let passwordInput = passwordTextField.text!
        let emailInput = emailTextField.text!
        
        if UserBase.CKUsers.testCKConnection() {
            if UserBase.CKUsers.checkIfUserHasAnAccount(email: emailInput) == .AccountExists {
                //User Already Has an Account Registered
                popUpNotification(title: Error, message: EmailHasAnAccount)
            }
            else {
                //Check if Username is Taken
                if UserBase.CKUsers.verifyUser(username: usernameInput) == .UsernameDoesNotExist {
                    UserBase.CKUsers.addUser(username: usernameInput, password: passwordInput, email: emailInput)
                    //Popup notification - Account is created, try logging in now
                    popUpNotification(title: CreatedAccount, message: NewAccountSignIn)
                    UserBase.CKUsers.saveUserBase()
                    self.goToLogInPageFromSignUp() //Go to login page if signup sucessfully.
                }
                else {
                    //Popup notification - Username already exists
                    popUpNotification(title: Error, message: UserNameAlreadyExists)
                }
            }
        }
        else {
            //Popup notification - not connected to cloud server
            popUpNotification(title: Error, message: CloudConnectionError)
        }
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
    let EmailHasAnAccount = "This Email Already Has An Account"
    
    func textFieldNoEditing(_ textfield: UITextField) {
        textfield.autocorrectionType = .no
        textfield.autocapitalizationType = .none
        textfield.spellCheckingType = .no
    }
}

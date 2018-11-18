
//  LogInViewController.swift
//  VideoGram Project Group 4
//
//  Created by student on 9/22/18.
//  Copyright © 2018 The-Windows-Specialists. All rights reserved.
//
import UIKit
import FBSDKLoginKit
class LogInController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let loginButton = FBSDKLoginButton()
        view.addSubview(loginButton)
        loginButton.frame = CGRect(x: 16, y: 50, width: view.frame.width - 32, height: 50)
    }
    
    @IBOutlet var passwordTextField: UITextField! {
        didSet{
            textFieldNoEditing(passwordTextField)
        }
    }
    @IBOutlet var usernameTextField: UITextField! {
        didSet {
            textFieldNoEditing(usernameTextField)
        }
    }
    
    @IBOutlet var test: UIButton!
    
    @IBOutlet var signInButton: UIButton!
    
    @IBOutlet var signUpButton: UIButton!
    
    
    @IBAction func logInPageToSignUpPage(_ sender: UIButton) {
        self.goToSignUp()
        print("loginpagetosignuppate")
    }
    
    @IBAction func TESTING_BUTTON(_ sender: UIButton) {
        self.goToMainPage()
    }
    @IBAction func signInAction(_ sender: UIButton) {
        let usernameInput = usernameTextField.text!
        let passwordInput = passwordTextField.text!
        
        if UserBase.CKUsers.testCKConnection() {
            if UserBase.CKUsers.verifyUser(username: usernameInput) == .UsernameExists {
                let signingUserIn = UserBase.CKUsers.login(username: usernameInput, password: passwordInput)
                if signingUserIn == .SuccessfulLogin {
                    self.goToMainPage()
                    //Popup notification - Login Successful
                    popUpNotification(title: LoginSuccessful, message: LoggingUserIn)
                }
                else {
                    //Popup notification - incorrect password
                    popUpNotification(title: Error, message: IncorrectPassword)
                }
            }
            else {
                //Popup notification- User DNE
                popUpNotification(title: Error, message: UserNameDoesNotExist)
            }
        }
        else {
            //Popup notification- not connected to Cloud Server
            popUpNotification(title: Error, message: CloudConnectionError)
        }
    }
    
    func goToMainPage() {
        performSegue(withIdentifier: "toMainPage", sender: nil)
        // print("other function")
    }
    
    func goToSignUp() {
        performSegue(withIdentifier: "SignUp", sender: nil)
    }
    
    func popUpNotification(title: String, message: String) {
        let popup = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        popup.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(popup, animated: true, completion:nil)
    }
    
    
    //ERROR MESSAGES
    let Error = "Error"
    let UserNameDoesNotExist = "Username Does Not Exist"
    let IncorrectPassword = "Incorrect Password"
    let LoginSuccessful = "Login Successful"
    let LoggingUserIn = "Logging user in..."
    let CloudConnectionError = "Cannot connect to CKDB"
    
    func textFieldNoEditing(_ textfield: UITextField) {
        textfield.autocorrectionType = .no
        textfield.autocapitalizationType = .none
        textfield.spellCheckingType = .no
    }
    
    
    
    
}

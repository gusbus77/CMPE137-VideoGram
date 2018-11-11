//
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
    
    
    @IBOutlet var back: UIButton!
    
    @IBOutlet var test: UIButton!
    
    @IBOutlet var albums: UIButton!
    
    @IBOutlet var shareVideo: UIButton!
    
    @IBOutlet var signInButton: UIButton!
    
    @IBOutlet var signUpButton: UIButton!
    
    @IBOutlet weak var resisterButton: UIButton!
    
    @IBOutlet weak var BackButton: UIButton!
    
    var userUid: String!
    
    func goToMainPage() {
        performSegue(withIdentifier: "toMainPage", sender: nil)
       // print("other function")
    }
    func goToLogInPageFromSignUp() {
        performSegue(withIdentifier: "SignupToLogin", sender: nil)
        print("other function")
    }
    
    func goToSignUp() {
        performSegue(withIdentifier: "SignUp", sender: nil)
        
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
    
    @IBAction func GoBackToLoginPage(_ sender: Any) {
        self.goToLogInPageFromSignUp()
    }
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
    
    
    
    @IBAction func CreateAccoutAction(_ sender: Any) {
       let usernameInput = usernameTextField.text!
        let passwordInput = passwordTextField.text!
        //let emailInput = emailTextField.text!
        
        if UserBase.CKUsers.testCKConnection() {
            if UserBase.CKUsers.verifyUser(username: usernameInput) == .UsernameDoesNotExist {
                UserBase.CKUsers.addUser(username: usernameInput, password: passwordInput)
                UserBase.CKUsers.saveUserBase()
                //Popup notification - Account is created, try logging in now
                self.goToLogInPageFromSignUp() //Go to login page if signup sucessfully.
                popUpNotification(title: CreatedAccount, message: NewAccountSignIn)
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
    
    
    func popUpNotification(title: String, message: String) {
        let popup = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        popup.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(popup, animated: true, completion:nil)
    }
    
    let Error = "Error"
    let UserNameAlreadyExists = "Username Already Exists"
    let UserNameDoesNotExist = "Username Does Not Exist"
    let IncorrectPassword = "Incorrect Password"
    let LoginSuccessful = "Login Successful"
    let LoggingUserIn = "Logging user in..."
    let CreatedAccount = "Created Account"
    let NewAccountSignIn = "Please log in."
    let CloudConnectionError = "Cannot connect to CKDB"
    
    func textFieldNoEditing(_ textfield: UITextField) {
        textfield.autocorrectionType = .no
        textfield.autocapitalizationType = .none
        textfield.spellCheckingType = .no
    }
    
    
    
    
}

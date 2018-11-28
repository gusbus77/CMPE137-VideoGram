
//  LogInViewController.swift
//  VideoGram Project Group 4
//
//  Created by student on 9/22/18.
//  Copyright © 2018 The-Windows-Specialists. All rights reserved.
//
import UIKit
import FBSDKLoginKit
class LogInController: UIViewController, FBSDKLoginButtonDelegate {
    
    var fbToken = false
    var userEmail:String = ""
    var userPicture:String = ""
    var userName:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let loginButton = FBSDKLoginButton()
        loginButton.delegate = self
        view.addSubview(loginButton)
        loginButton.frame = CGRect(x: 64, y: 555, width: view.frame.width - 128, height: 50)
    }
    
    override func viewDidAppear(_ animated:Bool) {
        //super.viewDidAppear(false)
        if(FBSDKAccessToken.current() != nil && fbToken == true) {
            print("performing Segue")
            self.performSegue(withIdentifier: "toMainPage", sender: self)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = true
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
    

    
    @IBOutlet var signInButton: UIButton!
    
    @IBOutlet var signUpButton: UIButton!
    
    
    @IBAction func logInPageToSignUpPage(_ sender: UIButton) {
        self.goToSignUp()
        print("loginpagetosignuppate")
    }
    
 
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("logout successfull")
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        print("loginButton Function Initiated")
        if ((error) != nil) {
            NSLog("Process Error")
        }
        else if result.isCancelled {
            NSLog("Cancelled")
        }
        else {
            print("Login success")
            self.getInfo()
            fbToken = true
        }
    }
    
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "GoToProfile") {
            print("PREPARE FUNCTION TRIGGERED")
            let vc1 = segue.destination as! UINavigationController
            let vc: ProfileController = vc1.topViewController as! ProfileController
            vc.currentUser = userEmail
            vc.currentUserPicture = userPicture
            vc.currentUserName = userName
 }
        
    }
    
    func getInfo(){
        print("getInfo is working")
        
        let info = ["fields": "email, first_name, last_name, picture.type(large)"]
        FBSDKGraphRequest(graphPath: "me", parameters: info).start {
            (connection, result, error) -> Void in
            if error != nil {
                print("error")
                return
            }
            
            if let result = result as? [String: AnyObject],
                let email: String = result["email"] as! String?
            {
                print(email)
                self.userEmail = email
            }
            
            if let result = result as? [String: AnyObject],
                let picture = result["picture"] as? NSDictionary, let data = picture["data"] as? NSDictionary,
                let url = data["url"] as? String {
                print(url)
                self.userPicture = url
            }
            
            if let result = result as? [String: AnyObject],
                let user = result["first_name"] as! String?
            {
                print(user)
                self.userName = user
            }
            
            
        }
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
        print("Go to main page")
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

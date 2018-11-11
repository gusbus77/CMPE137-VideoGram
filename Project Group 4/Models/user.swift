import Foundation
import CloudKit
// ToDo: Add email verification when registering, send an email to users
//enum RegistrationResults {
//    case InvalidEmailAddress
//    case PasswordNotStrongEnough
//    case RegistrationFailed
//    case SuccessfulRegistration
//}
enum LoginResults {
    case AccountDoesNotExist
    case AccountExists
    case IncorrectPassword
    case SuccessfulLogin
}
struct User {
    var username: String = ""
    var password: String = ""
    var email: String = ""
    //var userID: Int = ""
}
class UserBase{
    static let CKUsers = UserBase()
    
    var users: [User] = []
    var privateCKDatabase: CKDatabase = CKContainer.default().privateCloudDatabase
    var publicCKDatabase: CKDatabase = CKContainer.default().publicCloudDatabase
    var sharedCKDatabase: CKDatabase = CKContainer.default().sharedCloudDatabase
    
    static var uniqueID = 0
    
    private init() {
    }
    
    func testCKConnection() -> Bool {
        if let _ = FileManager.default.ubiquityIdentityToken {
            return true
        }
        else {
            return false
        }
    }
    
    func loadUserBase() {
        users = []
        
        let predicate = NSPredicate(value:true)
        let query = CKQuery(recordType: "User", predicate: predicate)
        privateCKDatabase.perform(query, inZoneWith: nil) { (records: [CKRecord]?, error: Error?) in
            if error == nil {
                guard let records = records else {
                    print ("No Records")
                    return
                }
                for record in records {
                    let username = record.object(forKey: "username") as! String
                    let password = record.object(forKey: "password") as! String
                    let email = record.object(forKey: "email") as! String
                    self.addUser(username: username, password: password, email: email)
                }
            }
            else {
                print (error?.localizedDescription ?? "Error")
            }
            
        }
    }
    
    func saveUserBase() {
        let record = CKRecord(recordType: "User")
        
        for user in users {
            record.setObject(user.username as CKRecordValue?, forKey: "username")
            record.setObject(user.password as CKRecordValue?, forKey: "password")
            record.setObject(user.email as CKRecordValue?, forKey: "email")
            privateCKDatabase.save(record) { (savedRecord: CKRecord?, error: Error?) -> Void in
                if error == nil {
                    return
                }
            }
        }
    }
    
    func addUser(usernameInput: String, passwordInput: String, emailInput: String) {
        let newUser = User(username: username, password: password, email: email)
        users.append(newUser)
    }
    
    func verifyUser(username: String)->LoginResults{
        if users.contains(where: {$0.username == username.lowercased()}) {
            return .AccountExists
        }
        else {
            return .AccountDoesNotExist
        }
    }
    
    func login(username: String, password: String)->LoginResults {
        let verification = verifyUser(username: username)
        
        if let user = users.first(where: {$0.username == username.lowercased()}) {
            if verification == .UsernameExists {
                if user.password == password {
                    return .SuccessfulLogin
                }
            }
        }
        return .IncorrectPassword
    }
    

    //TODO
    //Add register throughu Social Media
    //Add email verification when registering new account
    //Check for password complexity when registering new account
    //Add 2-step verification
    
}

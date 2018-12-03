import Foundation
import CloudKit

enum LoginResults {
    case AccountDoesNotExist
    case AccountExists
    case UsernameExists
    case UsernameDoesNotExist
    case IncorrectPassword
    case SuccessfulLogin
}
struct User {
    var username: String = ""
    var password: String = ""
    //var uniqueuserID: Int = ""
}

class UserBase{
    static let CKUsers = UserBase()
    
    var users: [User] = []
    var privateCKDatabase: CKDatabase = CKContainer.default().privateCloudDatabase
    
    static var uniqueID = 0
    
    private init() {
    }
    
    func testCKConnection() -> Bool {
        if FileManager.default.ubiquityIdentityToken != nil {
            return true
        }
        else {
            return false
        }
    }
    
    func loadUserBase() {
        let predicate = NSPredicate(value:true)
        let query = CKQuery(recordType: "User", predicate: predicate)
        
        privateCKDatabase.perform(query, inZoneWith: nil) { (records: [CKRecord]?, error: Error?) in
            if error == nil {
                guard let records = records else {
                    print ("No Records")
                    return
                }
                for record in records {
                    let fetchUser = User(username: record.object(forKey: "username") as! String, password: record.object(forKey: "password") as! String)
                    print (fetchUser.username)
                    self.users.append(fetchUser)
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
            privateCKDatabase.save(record) { (savedRecord: CKRecord?, error: Error?) -> Void in
                if error == nil {
                    return
                }
            }
        }
    }
    
    func addUser(username: String, password: String) {
        let newUser = User(username: username, password: password)
        users.append(newUser)
    }
    
    
    func verifyUser(username: String)->LoginResults{
        if users.contains(where: {$0.username == username}) {
            return .UsernameExists
        }
        else {
            return .UsernameDoesNotExist
        }
    }


    func login(username: String, password: String)->LoginResults {        
        if let user = users.first(where: {$0.username == username.lowercased()}) {
            if user.password == password {
                return .SuccessfulLogin
            }
        }
        return .IncorrectPassword
    }
    
}

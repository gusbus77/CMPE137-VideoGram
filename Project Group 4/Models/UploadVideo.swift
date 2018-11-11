//
//  UploadVideo.swift
//  Project Group 4
//
//  Created by student on 11/11/18.
//  Copyright © 2018 The WIndow Specialists. All rights reserved.
//

import Foundation
import UIKit
import CloudKit

class Video: NSObject {
    var videoID:            String = ""
    var videoName:          String = ""
    var videoDescription:   String = ""
    var publicVid:          Bool = ""
}

class UploadVideo {
    static let CKVideo = UploadVideo()
    
    var videos: [Video] = []
    var privateCKDatabase: CKDatabase = CKContainer.default().privateCloudDatabase
    var publicCKDatabase: CKDatabase = CKContainer.default().publicCloudDatabase

    func loadVideo() {
        let predicate = NSPredicate(value:true)
        let query = CKQuery(recordType: "Video", predicate: predicate)
        privateCKDatabase.perform(query, inZoneWith: nil) { (records: [CKRecord]?, error: Error?) in
            if error == nil {
                guard let records = records else {
                    print ("No Records")
                    return
                }
                for record in records {
                    let videoID = record.object(forKey: "videoID") as! String
                    let videoName = record.object(forKey: "videoName") as! String
                    let videoDescription = record.object(forKey: "videoDescription") as! String
                    let publicVid = record.object(forKey: "publicVid") as! Bool
                    //self.addUser(username: username, password: password, email: email)
                }
            }
            else {
                print (error?.localizedDescription ?? "Error")
            }
            
        }
    }
    
    func saveVideo() {
        let record = CKRecord(recordType: "Video")
        
        for video in videos {
            record.setObject(video.videoID as CKRecordValue?, forKey: "videoID")
            record.setObject(video.videoName as CKRecordValue?, forKey: "videoName")
            record.setObject(video.videoDescription as CKRecordValue?, forKey: "videoDescription")
            record.setObject(video.publicVid as CKRecordValue?, forKey: "publicVid")
            privateCKDatabase.save(record) { (savedRecord: CKRecord?, error: Error?) -> Void in
                if error == nil {
                    return
                }
            }
            if video.publicVid == True {
                publicCKDatabase.save(record) { (savedRecord: CKRecord?, error: Error?) -> Void in
                    if error == nil {
                        return
                    }
                }
            }
        }
    }
    
    func uploadVideo(VideoToSave: ) {
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
}

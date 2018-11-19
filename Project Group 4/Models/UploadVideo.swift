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

//Not sure if this is per user session, or to db in general D: need to test

class Video: NSObject {
    var username:           String = ""
    var videoName:          String = ""
    var videoDescription:   String = ""
    var videoThumbnail:     String = ""
    var publicVid:          String = "" // might change to bool
    //var vidData:            CKAsset, some type of path
}

class UploadVideo: NSObject {
    static let CKVideo = UploadVideo()
    
    //Creates an array of Video class (class because we need inheritance)
    var videos: [Video] = []
    
    var privateCKDatabase: CKDatabase = CKContainer.default().privateCloudDatabase
    var publicCKDatabase: CKDatabase = CKContainer.default().publicCloudDatabase
    var sharedCKDatabase: CKDatabase = CKContainer.default().sharedCloudDatabase
    
    //Loads and returns an array of user's videos
    func loadPrivateVideos() -> [Video] {
        let predicate = NSPredicate(value:true)
        let query = CKQuery(recordType: "Video", predicate: predicate)
        var gotVids = [Video]()
        let loadingVid = Video()
        privateCKDatabase.perform(query, inZoneWith: nil) { (records: [CKRecord]?, error: Error?) in
            if error == nil {
                guard let records = records else {
                    print ("No Records")
                    return
                }
                for record in records {
                    loadingVid.username = record.object(forKey: "username") as! String
                    loadingVid.videoName = record.object(forKey: "videoName") as! String
                    loadingVid.videoDescription = record.object(forKey: "videoDescription") as! String
                    loadingVid.videoThumbnail = record.object(forKey: "videoThumbnail") as! String
                    loadingVid.publicVid = record.object(forKey: "publicVid") as! String
                    gotVids.append(loadingVid)
                }
            }
            else {
                print (error?.localizedDescription ?? "Error")
            }
        }
        return gotVids
    }
    //Loads and returns an array of public videos
    func loadPublicVideos() -> [Video] {
        let predicate = NSPredicate(value:true)
        let query = CKQuery(recordType: "Video", predicate: predicate)
        var gotVids = [Video]()
        let loadingVid = Video()
        publicCKDatabase.perform(query, inZoneWith: nil) { (records: [CKRecord]?, error: Error?) in
            if error == nil {
                guard let records = records else {
                    print ("No Records")
                    return
                }
                for record in records {
                    loadingVid.username = record.object(forKey: "username") as! String
                    loadingVid.videoName = record.object(forKey: "videoName") as! String
                    loadingVid.videoDescription = record.object(forKey: "videoDescription") as! String
                    loadingVid.videoThumbnail = record.object(forKey: "videoThumbnail") as! String
                    loadingVid.publicVid = record.object(forKey: "publicVid") as! String
                    gotVids.append(loadingVid)
                }
            }
            else {
                print (error?.localizedDescription ?? "Error")
            }
        }
        return gotVids
    }
    
    //Loads and returns an array of shared videos for album view (will work on this)
    func loadSharedVideos() -> [Video] {
        let predicate = NSPredicate(value:true)
        let query = CKQuery(recordType: "Video", predicate: predicate)
        var gotVids = [Video]()
        let loadingVid = Video()
        sharedCKDatabase.perform(query, inZoneWith: nil) { (records: [CKRecord]?, error: Error?) in
            if error == nil {
                guard let records = records else {
                    print ("No Records")
                    return
                }
                for record in records {
                    loadingVid.username = record.object(forKey: "username") as! String
                    loadingVid.videoName = record.object(forKey: "videoName") as! String
                    loadingVid.videoDescription = record.object(forKey: "videoDescription") as! String
                    loadingVid.videoThumbnail = record.object(forKey: "videoThumbnail") as! String
                    loadingVid.publicVid = record.object(forKey: "publicVid") as! String
                    gotVids.append(loadingVid)
                }
            }
            else {
                print (error?.localizedDescription ?? "Error")
            }
        }
        return gotVids
    }
    
    func saveVideo() {
        let record = CKRecord(recordType: "Video")
        
        for video in videos {
            record.setObject(video.username as CKRecordValue?, forKey: "username")
            record.setObject(video.videoName as CKRecordValue?, forKey: "videoName")
            record.setObject(video.videoDescription as CKRecordValue?, forKey: "videoDescription")
            record.setObject(video.videoThumbnail as CKRecordValue?, forKey: "videoThumbnail")
            record.setObject(video.publicVid as CKRecordValue?, forKey: "publicVid")
            privateCKDatabase.save(record) { (savedRecord: CKRecord?, error: Error?) -> Void in
                if error == nil {
                    return
                }
            }
            if video.publicVid == "Yes" { //might change to bool
                publicCKDatabase.save(record) { (savedRecord: CKRecord?, error: Error?) -> Void in
                    if error == nil {
                        return
                    }
                }
            }
        }
    }
    
    func uploadVideo(username: String, videoName: String, videoDescription: String, videoThumbnail: String, publicVid: String) { //, videoData: CKAsset) {
        let newVideo: Video = Video()
        newVideo.username = username
        newVideo.videoName = videoName
        newVideo.videoDescription = videoDescription
        newVideo.videoThumbnail = videoThumbnail
        newVideo.publicVid = publicVid
        videos.append(newVideo)
    }
    
}

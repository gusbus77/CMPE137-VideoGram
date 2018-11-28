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
    var videoID:            Int = 0
    var videoDescription:   String = ""
    var publicVid:          Int    = 0 //0: False, 1: True
    var videoImg:           CKAsset?
    var videoData:          CKAsset?

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
        let query = CKQuery(recordType: "Videos", predicate: predicate)
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
                    loadingVid.videoID = record.object(forKey: "videoID") as! Int
                    loadingVid.videoDescription = record.object(forKey: "videoDescription") as! String
                    loadingVid.publicVid = record.object(forKey: "publicVid") as! Int
                    loadingVid.videoImg = record.object(forKey: "vidImg") as? CKAsset
                    loadingVid.videoData = record.object(forKey: "videoData") as? CKAsset
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
        //Predicate needs to Query all entries where publicVid == 1
        let predicate = NSPredicate(value:true)
        let query = CKQuery(recordType: "Videos", predicate: predicate)
        
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
                    loadingVid.videoID = record.object(forKey: "videoID") as! Int
                    loadingVid.videoDescription = record.object(forKey: "videoDescription") as! String
                    loadingVid.publicVid = record.object(forKey: "publicVid") as! Int
                    loadingVid.videoImg = record.object(forKey: "vidImg") as? CKAsset
                    loadingVid.videoData = record.object(forKey: "videoData") as? CKAsset
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
        let query = CKQuery(recordType: "Videos", predicate: predicate)
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
                    loadingVid.videoID = record.object(forKey: "videoID") as! Int
                    loadingVid.videoDescription = record.object(forKey: "videoDescription") as! String
                    loadingVid.publicVid = record.object(forKey: "publicVid") as! Int
                    loadingVid.videoImg = record.object(forKey: "vidImg") as? CKAsset
                    loadingVid.videoData = record.object(forKey: "videoData") as? CKAsset
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
        let record = CKRecord(recordType: "Videos")
        
        for video in videos {
            record.setObject(video.username as CKRecordValue?, forKey: "username")
            record.setObject(video.videoID as CKRecordValue?, forKey: "videoID")
            record.setObject(video.videoDescription as CKRecordValue?, forKey: "videoDescription")
            record.setObject(video.publicVid as CKRecordValue?, forKey: "publicVid")
            record.setObject(video.videoImg as CKRecordValue?, forKey: "vidImg")
            record.setObject(video.videoData as CKRecordValue?, forKey: "videoData")
            privateCKDatabase.save(record) { (savedRecord: CKRecord?, error: Error?) -> Void in
                if error == nil {
                    return
                }
            }
            if video.publicVid == 1 { //0: False, 1: True
                publicCKDatabase.save(record) { (savedRecord: CKRecord?, error: Error?) -> Void in
                    if error == nil {
                        return
                    }
                }
            }
        }
    }
    
    func uploadVideo(username: String, videoID: Int, videoDescription: String, publicVid: Int, imgData: CKAsset, vidData: CKAsset) {
        let newVideo: Video = Video()
        newVideo.username = username
        newVideo.videoID = videoID
        newVideo.videoDescription = videoDescription
        newVideo.publicVid = publicVid
        newVideo.videoImg = imgData
        newVideo.videoData = vidData
        videos.append(newVideo)
    }
    
}

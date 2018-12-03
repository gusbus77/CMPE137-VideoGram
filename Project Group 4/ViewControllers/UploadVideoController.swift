//
//  UploadVideoController.swift
//  Project Group 4
//
//  Created by student on 11/11/18.
//  Copyright © 2018 The WIndow Specialists. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import CloudKit
import MobileCoreServices
import FBSDKLoginKit

class UploadVideoController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBAction func logOut(_ sender: UIButton) {
        print("logout works")
        self.logOut()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "profileLogOut4") {
            print("PREPARE FUNCTION TRIGGERED IN PROFILE CONTROLLER")
            FBSDKLoginManager().logOut()
        }
    }
    
    func logOut() {
        FBSDKLoginManager().logOut()
        print("logout works again")
        performSegue(withIdentifier: "ToLogInPage", sender: nil)
        //self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBOutlet weak var selectVideoButton : UIButton!
    
    @IBOutlet weak var vidDescriptionTextField : UITextField!
    
    @IBOutlet weak var uploadButton : UIBarButtonItem!
    
    @IBOutlet weak var previewThumbnail: UIImageView!
    
    let videoPicker = UIImagePickerController()
    let docDirectoryPath:NSString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
    let docDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    var vidIDCounter: Int = 0
    
    @IBAction func selectVideo(_ sender: Any) {
        videoPicker.sourceType = .photoLibrary
        videoPicker.mediaTypes = ["public.movie"];
        videoPicker.delegate = self
        self.present(videoPicker, animated: true, completion: nil)
    }
    
    @IBAction func uploadVideoButton(_ sender: Any) {
        UploadVideo.CKVideo.saveVideo()
        popUpNotification(title: Success, message: Uploaded)
        
        //Perform Segue to VideoFeed
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var thumbnail: UIImage!
        var vidURL: URL!
        
        if let fileurl = info[UIImagePickerControllerMediaURL] as? URL {
            //Gets Thumbnail for Video
            let videoImg = AVAsset(url: fileurl)
            let imgThumbnail = videoImg.getThumbnail
            previewThumbnail.image = imgThumbnail
            
            //Save videoURL and thumbnail to struct
            vidURL = fileurl
            thumbnail = imgThumbnail
            
            //Append the Video to UploadVideo Class Video Array
            self.importVideo(vidURL, thumbnail)
            
            //Dismiss Picker
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
    func importVideo(_ videourl: URL?, _ thumbnailimage: UIImage?) {
        var imgAsset: CKAsset!
        var vidAsset: CKAsset!
        var imgURL: URL!
        
        if let image = thumbnailimage {
            let imageData:Data = UIImageJPEGRepresentation(image, 1.0)!
            let path:String = self.docDirectoryPath.appendingPathComponent("thumbnail.jpg")
            try? UIImageJPEGRepresentation(image, 1.0)!.write(to: URL(fileURLWithPath: path), options: [.atomic])
            imgURL = URL(fileURLWithPath: path)
            try? imageData.write(to: imgURL, options: [.atomic])
            //Save Thumbnail as a CKAsset
            imgAsset = CKAsset(fileURL: URL(fileURLWithPath: path))
        }
        
        //Gets text string from textfield
        let description = vidDescriptionTextField.text!
        
        //Save videoURL as CKAsset
        vidAsset = CKAsset(fileURL: videourl!)
        
        //Appends Video to User's Array of Videos to Save to CKDB
        UploadVideo.CKVideo.uploadVideo(username: "mlauzon", videoID: vidIDCounter, videoDescription: description, publicVid: 1, imgData: imgAsset, vidData: vidAsset)
        
        //Increment vidID
        vidIDCounter = vidIDCounter + 1
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vidDescriptionTextField.delegate = self
    }
    
    //Maximum Vid Description Text Field
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = vidDescriptionTextField.text else {return true}
        let count = text.count + string.count - range.length
        return count <= 240
    }

    func popUpNotification(title: String, message: String) {
        let popup = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        popup.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(popup, animated: true, completion:nil)
    }
    
    let Error = "Error"
    let Success = "Success"
    let CannotGetThumbnailUrl = "Cannot get thumbnail URL"
    let CannotSaveMovieToDocumentDirectory = "Cannot Save Movie To Document Directory"
    let CannotClearTmpDir = "Cannot Clear Temporary Directory"
    let Uploaded = "Video Successfully Uploaded"
}

extension AVAsset {
    var getThumbnail:UIImage? {
        let assetImageGenerator = AVAssetImageGenerator(asset: self)
        assetImageGenerator.appliesPreferredTrackTransform = true
        
        var time = self.duration
        time.value = min(time.value, 2)
        
        do {
            let imageReference = try assetImageGenerator.copyCGImage(at: time, actualTime: nil)
            let thumbnail = UIImage.init(cgImage: imageReference)
            
            return thumbnail
        } catch {
            return nil
        }
        
    }
}



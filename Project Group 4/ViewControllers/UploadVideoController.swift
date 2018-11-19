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
import MobileCoreServices

class UploadVideoController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @IBOutlet weak var selectVideoButton : UIButton!
    
    @IBOutlet weak var vidDescriptionTextField : UITextField!
    
    @IBOutlet weak var uploadButton : UIButton!
    
    @IBOutlet weak var previewThumbnail: UIImageView!
    
    let videoPicker = UIImagePickerController()
    //var selec
    @IBAction func selectVideo(_ sender: Any) {
        videoPicker.sourceType = .photoLibrary
        videoPicker.mediaTypes = ["public.movie"];
        videoPicker.delegate = self
        self.present(videoPicker, animated: true, completion: nil)
    }
    
    @IBAction func uploadVideo(_ sender: Any) {
        let description = vidDescriptionTextField.text
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let videoURL = info[UIImagePickerControllerMediaURL] as? URL {
            let video = NSData(contentsOf: videoURL)
            let videoImg = AVAsset(url: videoURL)
            let previewThumbnail = videoImg.getThumbnail
            picker.dismiss(animated: true, completion: nil)
        }
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

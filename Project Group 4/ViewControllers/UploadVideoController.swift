//
//  UploadVideoController.swift
//  Project Group 4
//
//  Created by student on 11/11/18.
//  Copyright © 2018 The WIndow Specialists. All rights reserved.
//

import Foundation
import UIKit
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
        videoPicker.delegate = self
        
        self.present(videoPicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let video = info[UIImagePickerControllerMediaType] as! UIImage
        
        previewThumbnail.image = video
        
        picker.dismiss(animated: true, completion: nil)
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

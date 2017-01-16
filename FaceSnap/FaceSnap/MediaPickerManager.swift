//
//  MediaPickerManager.swift
//  FaceSnap
//
//  Created by James Estrada on 11/01/2017.
//  Copyright © 2017 James Estrada. All rights reserved.
//

import UIKit
import MobileCoreServices

protocol MediaPickerManagerDelegate: class { //restrict this protocol to only classes can implement it
    func mediaPickerManager(manager: MediaPickerManager, didFinishPickingImage image: UIImage)
}

class MediaPickerManager: NSObject {
    private let imagePickerController = UIImagePickerController()
    
    //dependency injection: the technique of providing everything a class needs for instantiation as initialization arguments
    private let presentingViewController: UIViewController //store property to mantain a reference to this view controller. View controller injection
    
    weak var delegate: MediaPickerManagerDelegate?
    
    init(presentingViewController: UIViewController) {
        self.presentingViewController = presentingViewController //dependency injection
        super.init()
        
        imagePickerController.delegate = self
        if UIImagePickerController.isSourceTypeAvailable(.Camera) { //defensive coding, if there's no camera available then we use the photo library.
            imagePickerController.sourceType = .Camera
            imagePickerController.cameraDevice = .Front
        } else {
            imagePickerController.sourceType = .PhotoLibrary
        }
        
        imagePickerController.mediaTypes = [kUTTypeImage as String] //restrict photo library media type to only images
    }
    
    func presentImagePickerController(animated animated: Bool) {
        presentingViewController.presentViewController(imagePickerController, animated: animated, completion: nil)
    }
    
    //api for dismissal
    func dismissImagePickerController(animated animated: Bool, completion: (() -> Void)) {
        imagePickerController.dismissViewControllerAnimated(animated, completion: completion)
    }
}

/*the reason we are conforming to UINavigationControllerDelegate is that an object that implements this protocol and acts as a delegate to the nav controller can modify
 behavior when a view controller is pushed or poppped from the stack. the UIImagePickerControllerDelegate protocol defines methods that your delegate object must
 implement to interact with the image picker interface such as when the user either picks an image or movie or even cancels the picker operation.
*/
extension MediaPickerManager: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        delegate?.mediaPickerManager(self, didFinishPickingImage: image)
    }
}


//
//  ViewController.swift
//  PickingImage
//
//  Created by Idelfonso Gutierrez Jr. on 8/25/16.
//  Copyright © 2016 idelfonso. All rights reserved.
//

import UIKit
/*
 To be a delegate of the UIImagePickerController your View Controller class will also need to conform to the UINavigationControllerDelegate protocol
 */

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    
    @IBOutlet weak var cameraButoon: UIBarButtonItem!
    
    let topDelefate = TopTextFieldDelegate()
    let bottomDelegate = BottomTextFieldDelegate()
    
    override func viewWillAppear(animated: Bool)
    {
        cameraButoon.enabled = UIImagePickerController.isSourceTypeAvailable(.Camera)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        topText.text = "TOP"
        bottomText.text = "BOTTOM"
        
        topText.textAlignment = .Center
        bottomText.textAlignment = .Center
        
        
        topText.delegate = topDelefate
        bottomText.delegate = bottomDelegate
        
        bottomText.layer.zPosition = 1
        topText.layer.zPosition = 1
        
//        let memeTextAttributes = [NSStrokeColorAttributeName: UIColor.whiteColor(), NSForegroundColorAttributeName: UIColor.blackColor(), NSFontAttributeName: UIFont(name:"HelveticaNeue-CondensedBlack", size: 40)!, NSStrokeWidthAttributeName: 2.0]
        
        let memeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName : -2.0 ]

        topText.defaultTextAttributes = memeTextAttributes
        bottomText.defaultTextAttributes = memeTextAttributes
    }

    @IBAction func pickAnImage(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .PhotoLibrary
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    

    @IBAction func takePhoto(sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .Camera
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }

    //ImagePickerControllerDelegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.image = image
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    

}


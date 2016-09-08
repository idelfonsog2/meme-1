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

struct Meme {
    var text: String
    var image: UIImage
    var memedImage: UIImage
    
    init(text: String, image: UIImage, memedImage: UIImage){
        self.text = text
        self.image = image
        self.memedImage = memedImage
    }
    
}

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    @IBOutlet weak var toolBarNav: UIToolbar!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    @IBOutlet weak var navigationBarTool: UINavigationBar!
    @IBOutlet weak var cameraButoon: UIBarButtonItem!
    
    let topDelefate = TopTextFieldDelegate()
    let bottomDelegate = BottomTextFieldDelegate()
    
    var savedMeme: Meme!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        topText.textAlignment = .Center
        bottomText.textAlignment = .Center
        
        topText.text = "TOP"
        bottomText.text = "BOTTOM"
        
        if (self.savedMeme != nil) {
            topText.text = savedMeme.text
            imagePickerView.image = savedMeme.image
        }
        
        
        topText.delegate = topDelefate
        bottomText.delegate = bottomDelegate
        
        bottomText.layer.zPosition = 1
        topText.layer.zPosition = 1
        
        shareButton.enabled = false
        
        let memeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName : -2.0 ]

        topText.defaultTextAttributes = memeTextAttributes
        bottomText.defaultTextAttributes = memeTextAttributes
    }
    
    override func viewWillAppear(animated: Bool)
    {
        cameraButoon.enabled = UIImagePickerController.isSourceTypeAvailable(.Camera)
        
        self.subscribeToKeyboardNotification()
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.unsubscribeFromKeyboardNotification()
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

    
    @IBAction func sharePicture(sender: AnyObject) {
        
        let memedImage = self.generatedMemedImage()
        let controller = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        
        self.presentViewController(controller, animated: true, completion: {self.save()})
        
        if controller.isBeingDismissed() {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
    }
    
    @IBAction func dismissController(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    //ImagePickerControllerDelegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.image = image
            shareButton.enabled = true
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    //MARK: NSNotification
    
    /*One can also create custom notifications using postNotificationName:.*/
    func keyboardWillShow(notification: NSNotification) {
        if bottomText.isFirstResponder() {
            self.view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if bottomText.isFirstResponder() {
            self.view.frame.origin.y += getKeyboardHeight(notification)
        }
    }
    
    func subscribeToKeyboardNotification() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo!
        let keyboardSize = userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }
    
    
    func unsubscribeFromKeyboardNotification() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    //MememedObject
    func save() {
        let meme = Meme(text: topText.text!+bottomText.text!, image: imagePickerView.image!, memedImage: self.generatedMemedImage())
        
        //aa it to the memes array on th applicationDelegate
        (UIApplication.sharedApplication().delegate as! AppDelegate).memes.append(meme)
        
    }
    
    func generatedMemedImage() -> UIImage
    {
        // TODO: Hide toolbar and navbar  
        toolBarNav.hidden = true
        navigationBarTool.hidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawViewHierarchyInRect(self.view.frame,
                                     afterScreenUpdates: true)
        let memedImage : UIImage =
            UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // TODO:  Show toolbar and navbar
        toolBarNav.hidden = false
        navigationController?.navigationBar.hidden = false
        
        return memedImage
    }
}


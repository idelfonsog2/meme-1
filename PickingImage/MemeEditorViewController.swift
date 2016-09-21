//
//  MemeEditorViewController.swift
//  PickingImage
//
//  Created by Idelfonso Gutierrez Jr. on 8/25/16.
//  Copyright © 2016 idelfonso. All rights reserved.
//

import UIKit
/*
 To be a delegate of the UIImagePickerController your View Controller class will also need to conform to the UINavigationControllerDelegate protocol
 */

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    @IBOutlet weak var toolBarNav: UIToolbar!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    @IBOutlet weak var navigationBarTool: UINavigationBar!
    @IBOutlet weak var cameraButoon: UIBarButtonItem!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    let memeTextDelegate = MemeTextFieldDelegate()
    
    var savedMeme: Meme!
    
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.black,
        NSForegroundColorAttributeName : UIColor.white,
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : -2.0 ] as [String : Any]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        topText.text = "TOP"
        bottomText.text = "BOTTOM"
        
        if (self.savedMeme != nil) {
            topText.text = savedMeme.text
            imagePickerView.image = savedMeme.image
        }
        
        shareButton.isEnabled = false
        saveButton.isEnabled = false
        
        configureTextField(topText)
        configureTextField(bottomText)
    }
    
    func configureTextField(_ textField: UITextField) {
        textField.delegate = memeTextDelegate
        textField.layer.zPosition = 1
        textField.defaultTextAttributes = memeTextAttributes
    }
    
    override func viewWillAppear(_ animated: Bool) {
        topText.textAlignment = .center
        bottomText.textAlignment = .center
        
        cameraButoon.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        self.subscribeToKeyboardNotification()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.unsubscribeFromKeyboardNotification()
    }

    @IBAction func pickAnImage(_ sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        if sender.tag == 3 {
            imagePicker.sourceType = .photoLibrary
        }
        else if sender.tag == 2 {
            imagePicker.sourceType = .camera
        }
        self.present(imagePicker, animated: true, completion: nil)
    }

    
    @IBAction func sharePicture(_ sender: AnyObject) {
        
        let memedImage = self.generatedMemedImage()
        let controller = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        
        self.present(controller, animated: true, completion: nil)
        
    }
    
    @IBAction func saveMemeBarButton(_ sender: UIBarButtonItem) {
        self.save()
        dismissController(sender)
    }

    @IBAction func dismissController(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: ImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.image = image
            shareButton.isEnabled = true
            saveButton.isEnabled = true
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    //MARK: NSNotification
    
    /*One can also create custom notifications using postNotificationName:.*/
    func keyboardWillShow(_ notification: Notification) {
        if bottomText.isFirstResponder {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(_ notification: Notification) {
        if bottomText.isFirstResponder {
            view.frame.origin.y += getKeyboardHeight(notification)
        }
    }
    
    func subscribeToKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(MemeEditorViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(MemeEditorViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = (notification as NSNotification).userInfo!
        let keyboardSize = userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    
    func unsubscribeFromKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    //MARK: MememedObject
    func save() {
        let meme = Meme(text: topText.text!, image: imagePickerView.image!, memedImage: self.generatedMemedImage(), bottomText: bottomText.text!)
        
        //aa it to the memes array on th applicationDelegate
        (UIApplication.shared.delegate as! AppDelegate).memes.append(meme)
        
    }
    
    func generatedMemedImage() -> UIImage {
        // TODO: Hide toolbar and navbar  
        toolBarNav.isHidden = true
        navigationBarTool.isHidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame,
                                     afterScreenUpdates: true)
        let memedImage : UIImage =
            UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // TODO:  Show toolbar and navbar
        toolBarNav.isHidden = false
        navigationBarTool.isHidden = false
        
        return memedImage
    }
}


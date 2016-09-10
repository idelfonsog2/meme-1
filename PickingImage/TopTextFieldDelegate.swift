//
//  TopTextFieldDelegate.swift
//  PickingImage
//
//  Created by Idelfonso Gutierrez Jr. on 8/26/16.
//  Copyright © 2016 idelfonso. All rights reserved.
//

import Foundation
import UIKit

class TopTextFieldDelegate: NSObject, UITextFieldDelegate {

    func textFieldDidBeginEditing(textField: UITextField) {
        if textField.text == "TOP" {
            textField.text = ""
        }
        if textField.text == "BOTTOM" {
            textField.text = ""
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        textField.textAlignment = .Center
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if textField.text == "" {
            textField.text = "TOP"
        }
        
        if textField.text == "" {
            textField.text = "BOTTOM"
        }
    }

    
    
}
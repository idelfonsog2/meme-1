//
//  MemeTextFieldDelegate.swift
//  PickingImage
//
//  Created by Idelfonso Gutierrez Jr. on 8/26/16.
//  Copyright © 2016 idelfonso. All rights reserved.
//

import Foundation
import UIKit

class MemeTextFieldDelegate: NSObject, UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == "TOP" {
            textField.text = ""
        }
        if textField.text == "BOTTOM" {
            textField.text = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        textField.textAlignment = .center
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == "" {
            textField.text = "TOP"
        }
        
        if textField.text == "" {
            textField.text = "BOTTOM"
        }
    }

    
    
}

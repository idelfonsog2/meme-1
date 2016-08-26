//
//  BottomTextFieldDelegate.swift
//  PickingImage
//
//  Created by Idelfonso Gutierrez Jr. on 8/26/16.
//  Copyright © 2016 idelfonso. All rights reserved.
//

import Foundation
import UIKit

class BottomTextFieldDelegate: NSObject, UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField.text == "BOTTOM" {
            textField.text = ""
        }
    }
}
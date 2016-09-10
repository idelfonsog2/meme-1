//
//  Meme.swift
//  PickingImage
//
//  Created by Idelfonso Gutierrez Jr. on 9/9/16.
//  Copyright © 2016 idelfonso. All rights reserved.
//

import Foundation
import UIKit

struct Meme {
    var text: String
    var image: UIImage
    var memedImage: UIImage
    var bottomText: String
    
    init(text: String, bottomText: String, image: UIImage, memedImage: UIImage){
        self.text = text
        self.image = image
        self.memedImage = memedImage
        self.bottomText = bottomText
    }
    
}
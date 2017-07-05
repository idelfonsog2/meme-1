//
//  MemeCollectionViewCell.swift
//  PickingImage
//
//  Created by Idelfonso Gutierrez Jr. on 9/4/16.
//  Copyright © 2016 idelfonso. All rights reserved.
//

import UIKit

class MemeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var topTextLabel: UILabel!
    @IBOutlet weak var bottomTextLabel: UILabel!
    
    func setText(_ topText: String, bottomText: String) {
        self.topTextLabel.text = topText
        self.bottomTextLabel.text = bottomText
    }
}

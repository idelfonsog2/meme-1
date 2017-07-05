//
//  MemeDetailViewController.swift
//  PickingImage
//
//  Created by Idelfonso Gutierrez Jr. on 9/19/16.
//  Copyright © 2016 idelfonso. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var detailMeme: Meme!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageView.image = detailMeme.memedImage
    }
}

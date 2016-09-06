//
//  MemeCollectionViewController.swift
//  PickingImage
//
//  Created by Idelfonso Gutierrez Jr. on 9/3/16.
//  Copyright © 2016 idelfonso. All rights reserved.
//

import Foundation
import UIKit

class MemeCollectionViewController: UICollectionViewController {

    var memes: [Meme]! {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(MemeCollectionViewController.presentMemeViewController))
    }
    
    func testAction(){
        print("sabve")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //CollectionViewController
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeItemCell", forIndexPath: indexPath)
        let meme = memes[indexPath.row]
        
        let imageView = UIImageView(image: meme.image)
        cell.backgroundView = imageView
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let controller = self.storyboard?.instantiateViewControllerWithIdentifier("ViewController") as! ViewController

        controller.savedMeme = self.memes[indexPath.row]
        
         self.presentViewController(controller, animated: true, completion: nil)
        
    }
    
    func presentMemeViewController() {
        let controller = self.storyboard?.instantiateViewControllerWithIdentifier("ViewController") as! ViewController
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
}
//
//  MemeTableViewController.swift
//  PickingImage
//
//  Created by Idelfonso Gutierrez Jr. on 9/4/16.
//  Copyright © 2016 idelfonso. All rights reserved.
//

import UIKit

class MemeTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var memes: [Meme]! {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .Bordered, target: self, action: #selector(MemeTableViewController.presentMemeCreator))
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MemeTableViewCell")!
        let meme = self.memes[indexPath.row]
        
        cell.imageView?.image = meme.memedImage
        cell.textLabel?.text = meme.text
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let controller = self.storyboard?.instantiateViewControllerWithIdentifier("ViewController") as! ViewController
        controller.savedMeme = self.memes[indexPath.row]
        
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    func presentMemeCreator() {
        let controller = self.storyboard?.instantiateViewControllerWithIdentifier("ViewController") as! ViewController
        
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
}

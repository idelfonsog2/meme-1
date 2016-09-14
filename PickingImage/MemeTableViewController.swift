//
//  MemeTableViewController.swift
//  PickingImage
//
//  Created by Idelfonso Gutierrez Jr. on 9/4/16.
//  Copyright © 2016 idelfonso. All rights reserved.
//

import UIKit

class MemeTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var memes: [Meme]! {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(MemeTableViewController.presentMemeCreator))
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        
    }
    
    //MARK: TableViewDelegate
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MemeTableViewCell", forIndexPath: indexPath) as UITableViewCell
        let meme = self.memes[indexPath.row]
        
        cell.imageView?.image = meme.image
        cell.textLabel?.text = meme.text
        cell.detailTextLabel?.text = meme.bottomText
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let controller = self.storyboard?.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController
        let meme = self.memes[indexPath.row]
        controller.savedMeme = meme
        
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
   //*Add edit of rows
    
    
    //MARK: Custom Func
    //The "Meme Detail View" needs not to be complicated. A simple view with just an image view as the one property would suffice
    
    func presentMemeCreator() {
        let controller = self.storyboard?.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController
        
        
        
        presentViewController(controller, animated: true, completion: nil)
    }
    
}

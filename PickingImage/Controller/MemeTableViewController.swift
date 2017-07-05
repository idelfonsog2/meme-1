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
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(MemeTableViewController.presentMemeCreator))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        
    }
    
    //MARK: TableViewDelegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTableViewCell", for: indexPath) as UITableViewCell
        let meme = self.memes[(indexPath as NSIndexPath).row]
        
        cell.imageView?.image = meme.image
        cell.textLabel?.text = meme.text
        cell.detailTextLabel?.text = meme.bottomText
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        controller.detailMeme = self.memes[(indexPath as NSIndexPath).row]
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
   //*Add edit of rows
    
    
    //MARK: Custom Func
    //The "Meme Detail View" needs not to be complicated. A simple view with just an image view as the one property would suffice
    
    func presentMemeCreator() {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "MemeEditorViewController") as! MemeEditorViewController
        
        
        
        present(controller, animated: true, completion: nil)
    }
    
}

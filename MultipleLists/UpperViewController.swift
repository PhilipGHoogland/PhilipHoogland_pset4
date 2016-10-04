//
//  UpperViewController.swift
//  MultipleLists
//
//  Created by Swift on 9/20/16.
//  Copyright © 2016 Swift. All rights reserved.
//


// FILLING WORKS
// GET DATA OBJECT WORKING BY ADDING SINGLETON
// ADDING WORKS
// SAVING NEDS TO BE IMPLEMENTED
// GOING TO DETAILS NEEDS TO BE IMPLEMENTED
// EVERYTHING IN DETAILS NEEDS TO BE IMPLEMENTED

import UIKit


class UpperViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    static let documentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    let archiveDirectory = documentsDirectory.URLByAppendingPathComponent("categories")
    
    //var categories = [Category]()
    var index: Int?
    @IBOutlet var itemTextField: UITextField!
    @IBOutlet var upperTableView: UITableView!
    @IBAction func buttonPressed(sender: AnyObject) {
        
        // WARNING: Codegasm incoming
        Categories.categories.append(Category(name: (itemTextField.text)!))
        // Codegasm ended
        
        itemTextField.text = ""
        upperTableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Categories.categories.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = upperTableView.dequeueReusableCellWithIdentifier("TableViewCell")! as UITableViewCell
        cell.textLabel?.text = (Categories.categories[indexPath.row].name)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        index = indexPath.row
        performSegueWithIdentifier("UpperToDetailsSegue", sender: AnyObject?())

    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete{
            Categories.categories.removeAtIndex(indexPath.row)
            upperTableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        upperTableView.delegate = self
        upperTableView.dataSource = self
        

        // Do any additional setup after loading the view.
    }
   
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        upperTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "UpperToDetailsSegue",
        let destination = segue.destinationViewController as? DetailsViewController,
        index = upperTableView.indexPathForSelectedRow?.row {
            destination.index = index
        }
        
    }

    /*
    // MARK: - Navigation

     
     
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

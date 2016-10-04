//
//  DetailsViewController.swift
//  MultipleLists
//
//  Created by Swift on 9/20/16.
//  Copyright © 2016 Swift. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    //var categoryReceiver: Category?
    var index: Int?
    @IBOutlet var detailsTableView: UITableView!
    @IBOutlet var itemTextField: UITextField!
    let doneText = " (done)"
    
    @IBAction func buttonPressed(sender: AnyObject) {
        Categories.categories[index!].items.append(Item(name: itemTextField.text!))
        detailsTableView.reloadData()
        itemTextField.text = ""
        Persistance.load()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailsTableView.delegate = self
        detailsTableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (Categories.categories[index!].items.count)
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete{
            Categories.categories[index!].items.removeAtIndex(indexPath.row)
            detailsTableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if ((Categories.categories[index!].items[indexPath.row].done) == true){
            Categories.categories[index!].items[indexPath.row].done = false
        }
        else{
            Categories.categories[index!].items[indexPath.row].done = true
        }
        detailsTableView.reloadData()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = detailsTableView.dequeueReusableCellWithIdentifier("TableViewCell")! as UITableViewCell
        
        if Categories.categories[index!].items[indexPath.row].done == true {
            cell.textLabel?.text = (Categories.categories[index!].items[indexPath.row].name) + doneText
            return cell
        }
        
        cell.textLabel?.text = (Categories.categories[index!].items[indexPath.row].name)
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

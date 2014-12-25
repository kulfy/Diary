//
//  EntryListViewController.swift
//  Diary
//
//  Created by anandam on 12/24/14.
//  Copyright (c) 2014 kulfy. All rights reserved.
//

import UIKit
import CoreData

class EntryListViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    
    let kCellIdentifier = "CellIdentifier"
        
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override init(style: UITableViewStyle)
    {
        super.init(style: style)
        
    }
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        //self.tableView.registerClass(cellClass: UITableViewCell, forCellReuseIdentifier: "Cell")
        self.fetchedResultsController.performFetch(nil);
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: kCellIdentifier)
        
        // uncomment this line to load table view cells programmatically
        //tableView.registerNib(UINib(nibName: "NibTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: kCellIdentifier)
        
        // uncomment this line to load table view cells from IB

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        //return 0
        return self.fetchedResultsController.sections!.count;
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        //return 0
        let sectionInfo = self.fetchedResultsController.sections![section] as NSFetchedResultsSectionInfo
        return sectionInfo.numberOfObjects
    }

     override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //let sectionInfo :NSFetchedResultsSectionInfo = self.fetchedResultsController?.sections(section);
        let sectionInfo : NSFetchedResultsSectionInfo = self.fetchedResultsController.sections(section);
           //var sectionnames = sectionInfo[section]
        
        return sectionInfo.name;
        
    }
    
    func entryListFetchRequest() -> NSFetchRequest{
        
        let fetchRequest = NSFetchRequest(entityName: "DiaryEntry")
        let sortDescriptor = NSSortDescriptor(key:"date", ascending: false)
        let sortDescriptors = [sortDescriptor]
        fetchRequest.sortDescriptors = [sortDescriptor]
        return fetchRequest
      
    }
    
    
    var fetchedResultsController: NSFetchedResultsController {
        // return if already initialized
        if self._fetchedResultsController != nil {
            return self._fetchedResultsController!
        }
        
        let coreDataStack: CoreDataStack = CoreDataStack.defaultStack;
        
        let fetchRequest: NSFetchRequest = self.entryListFetchRequest();
        
        let managedContext: NSManagedObjectContext = coreDataStack.managedObjectContext!
    
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedContext, sectionNameKeyPath: "sectionName", cacheName: nil)
        
        aFetchedResultsController.delegate = self
        
        self._fetchedResultsController = aFetchedResultsController
    
        return _fetchedResultsController!;
    
    }
    
    var _fetchedResultsController: NSFetchedResultsController?

   
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //let reuseIdentifier: NSString = "Cell";
        // let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell
        
        let CellIdentifier: NSString = "Cell";
        let cell = tableView.dequeueReusableCellWithIdentifier("CellIdentifier", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...
        
        let entry: DiaryEntry = self.fetchedResultsController.objectAtIndexPath(indexPath) as DiaryEntry;
        
        cell.textLabel?.text = entry.body;
        
        return cell;
    }
    
    /* called first
    begins update to `UITableView`
    ensures all updates are animated simultaneously */
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        self.tableView.reloadData()
    }
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}

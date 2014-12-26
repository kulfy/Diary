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
    
    let kCellIdentifier: NSString = "CellIdentifier"
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!){
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override init(style: UITableViewStyle){
        super.init(style: style)
    }
    
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        println("EntryListViewController - viewDidLoad()");
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        //self.tableView.registerClass(cellClass: UITableViewCell, forCellReuseIdentifier: "Cell")
        self.fetchedResultsController.performFetch(nil);
        
        //tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: kCellIdentifier)
        tableView.registerClass(EntryCell.self, forCellReuseIdentifier: kCellIdentifier)

        
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
    
    //delete - part1
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let entry: DiaryEntry = self.fetchedResultsController.objectAtIndexPath(indexPath) as DiaryEntry;
        let coreDataStack: CoreDataStack = CoreDataStack.defaultStack;
        let managedContext: NSManagedObjectContext = coreDataStack.managedObjectContext!
        
        managedContext.deleteObject(entry);
        
        coreDataStack.saveContext();
    }
    
    //delete - part2
    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.Delete;
    }
    
    //section name
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //let sectionInfo :NSFetchedResultsSectionInfo = self.fetchedResultsController?.sections(section);
        let sectionInfo : NSFetchedResultsSectionInfo = self.fetchedResultsController.sections?[section] as NSFetchedResultsSectionInfo;
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
    
    var _fetchedResultsController: NSFetchedResultsController?
    
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
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        println("EntryListViewController - cellForRowAtIndexPath()");
        let CellIdentifier: NSString = "Cell";
        let cell: EntryCell = tableView.dequeueReusableCellWithIdentifier("CellIdentifier", forIndexPath: indexPath) as EntryCell;
        
        // Configure the cell...
        let entry: DiaryEntry = self.fetchedResultsController.objectAtIndexPath(indexPath) as DiaryEntry;
        //cell.textLabel?.text = entry.body;
        
        [cell.configureCellForEntry(entry)];
        return cell;
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
         //println("EntryListViewController - heightForRowAtIndexPath()");
        let entryCell: EntryCell = EntryCell();
        let entry: DiaryEntry = self.fetchedResultsController.objectAtIndexPath(indexPath) as DiaryEntry;
        return entryCell.heightForEntry(entry);
    }

    
    
    /* called first
    begins update to `UITableView`
    ensures all updates are animated simultaneously */
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        
        //if animation not required delete below method, controllerdidChangeContent and just use the reloadData below.
        //self.tableView.reloadData()
        
        self.tableView.beginUpdates();
        
    }
    
    //called when a row is inserted,deleted, changed or moved.
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch (type){
        case NSFetchedResultsChangeType.Insert:
            self.tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: UITableViewRowAnimation.Automatic);
            break;
        case NSFetchedResultsChangeType.Delete:
            self.tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation:UITableViewRowAnimation.Automatic );
            break;
            
        case NSFetchedResultsChangeType.Update:
            self.tableView.reloadRowsAtIndexPaths([indexPath!], withRowAnimation:UITableViewRowAnimation.Automatic );
            break;
        default:
            return
            
        }
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.endUpdates();
    }
    
    
    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        switch (type){
        case NSFetchedResultsChangeType.Insert:
            self.tableView.insertRowsAtIndexPaths([NSIndexSet(index: sectionIndex)], withRowAnimation: UITableViewRowAnimation.Automatic);
            break;
        case NSFetchedResultsChangeType.Delete:
            self.tableView.deleteRowsAtIndexPaths([NSIndexSet(index: sectionIndex)], withRowAnimation:UITableViewRowAnimation.Automatic );
            break;
        default:
            return
        }
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
        println("prepareForSegue");
        println("segue \(segue.identifier)");
        if segue.identifier == "edit" {
            println("inside prepareForSegue");
             let cell: UITableViewCell  = sender? as UITableViewCell;
             let indexPath: NSIndexPath! = self.tableView.indexPathForCell(cell);
             let navigationController: UINavigationController = segue.destinationViewController as UINavigationController;
             let entryViewController:EntryViewController = navigationController.topViewController as EntryViewController;
            entryViewController.entry = self.fetchedResultsController.objectAtIndexPath(indexPath) as? DiaryEntry;
        }
        
    }
    
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the specified item to be editable.
    return true
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
    

    
}

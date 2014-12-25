//
//  NewEntryViewController.swift
//  Diary
//
//  Created by anandam on 12/23/14.
//  Copyright (c) 2014 kulfy. All rights reserved.
//

import UIKit
import CoreData


class NewEntryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBOutlet var textField: UITextField!
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func dismissSelf() {
        
        [self.presentingViewController?.dismissViewControllerAnimated(true,completion: nil)];
    
    }
    
    
    func insertDiaryEntry(){
        
        //let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
        let coreDataStack: CoreDataStack = CoreDataStack.defaultStack;
        
        let managedContext: NSManagedObjectContext = coreDataStack.managedObjectContext!

        let entry: DiaryEntry = NSEntityDescription.insertNewObjectForEntityForName("DiaryEntry", inManagedObjectContext:managedContext) as DiaryEntry
        
        entry.body = self.textField.text;
        
        //let dated: NSDate = NSDate();
        
        entry.date = NSTimeInterval();
            
        coreDataStack.saveContext();
        
    }
 
    
    
    @IBAction func doneWasPressed(sender: AnyObject) {
        [self.insertDiaryEntry()];
        [self .dismissSelf()];
    }
    
    
    @IBAction func cancelWasPressed(sender: AnyObject) {
        [self .dismissSelf()];
    }
}

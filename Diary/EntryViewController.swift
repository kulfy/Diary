//
//  NewEntryViewController.swift
//  Diary
//
//  Created by anandam on 12/23/14.
//  Copyright (c) 2014 kulfy. All rights reserved.
//

import UIKit
import CoreData


class EntryViewController: UIViewController {
    
    var entry:DiaryEntry? = DiaryEntry();
    
    @IBOutlet var textField: UITextField!
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!)
    {
        textField = UITextField();
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.entry != nil {
            self.textField.text = self.entry?.body;
        }

        // Do any additional setup after loading the view.
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
    
    func dismissSelf() {
        
        [self.presentingViewController?.dismissViewControllerAnimated(true,completion: nil)];
    
    }
    
    
    func insertDiaryEntry(){
        
        //let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
        let coreDataStack: CoreDataStack = CoreDataStack.defaultStack;
        
        let managedContext: NSManagedObjectContext = coreDataStack.managedObjectContext!

        let entry: DiaryEntry = NSEntityDescription.insertNewObjectForEntityForName("DiaryEntry", inManagedObjectContext:managedContext) as DiaryEntry
        
        entry.body = self.textField.text;
        
        entry.date = NSTimeInterval();
        
        //let dated: NSTimeInterval = NSTimeInterval;
        
        //entry.date = dated;
        
        
        //date
         //let dated: NSDate = NSDate();
         //entry.date = dated;
            
        coreDataStack.saveContext();
        
    }
 
    
    func updateDiaryEntry(){
        self.entry?.body = self.textField.text;
        
        let coreDataStack: CoreDataStack = CoreDataStack.defaultStack;
        
        coreDataStack.saveContext();
        
    }
    
    @IBAction func doneWasPressed(sender: AnyObject) {
        
        if self.entry != nil{
            [self.updateDiaryEntry()];
        }else{
            [self.insertDiaryEntry()];

        }
        
        [self .dismissSelf()];
    }
    
    
    @IBAction func cancelWasPressed(sender: AnyObject) {
        [self .dismissSelf()];
    }
}

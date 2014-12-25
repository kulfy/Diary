//
//  DiaryEntry.swift
//  Diary
//
//  Created by anandam on 12/23/14.
//  Copyright (c) 2014 kulfy. All rights reserved.
//

import Foundation
import CoreData


class DiaryEntry: NSManagedObject {

    @NSManaged var date: NSTimeInterval
    @NSManaged var body: String
    @NSManaged var imageData: NSData
    @NSManaged var mood: Int16
    @NSManaged var location: String
    
    var sectionName: NSString{
        
            let dated: NSDate = NSDate(timeIntervalSince1970: self.date);
            
            let dateFormatter :NSDateFormatter = NSDateFormatter.alloc();
        
            //to-do: cache the formatter
            dateFormatter.dateFormat = "MMM yyyy";
            
            return dateFormatter.stringFromDate(dated);
        
    }
    

}

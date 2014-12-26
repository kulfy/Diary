//
//  DateFormatManager.swift
//  Diary
//
//  Created by anandam on 12/24/14.
//  Copyright (c) 2014 kulfy. All rights reserved.
//

import Foundation

class DateformatterManager {
    var formatter = NSDateFormatter()
    
    class var dateFormatManager : DateformatterManager {
        struct Static {
            static let instance : DateformatterManager = DateformatterManager()
        }
        // date shown as date in some tableviews
        Static.instance.formatter.dateFormat = "yyyy-MM-dd"
        return Static.instance
    }
    
    class var dateFormatSpelledManager : DateformatterManager {
        struct Static {
            static let instance : DateformatterManager = DateformatterManager()
        }
        // date shown as date in some tableviews
        Static.instance.formatter.dateFormat = "EEEE, MMMMM d yyyy"
        return Static.instance
    }
    
    class var timeFormatManager : DateformatterManager {
        struct Static {
            static let instance : DateformatterManager = DateformatterManager()
        }
        // date shown as time in some tableviews
        Static.instance.formatter.dateFormat = "HH:mm"
        return Static.instance
    }
    
    // MARK: - Helpers
    func stringFromDate(date: NSDate) -> String {
        return self.formatter.stringFromDate(date)
    }
    func dateFromString(date: String) -> NSDate? {
        return self.formatter.dateFromString(date)!
    }
}
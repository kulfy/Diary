//
//  EntryCell.swift
//  Diary
//
//  Created by anandam on 12/26/14.
//  Copyright (c) 2014 kulfy. All rights reserved.
//

import UIKit

class EntryCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var moodImageView: UIImageView!
    
    
//    init(style: UITableViewCell){
//        self.bodyLabel = UILabel();
//        self.locationLabel = UILabel();
//        self.dateLabel = UILabel();
//
//       // super.init(style: style)
//    }
//    
//    required init(coder aDecoder: NSCoder){
//        super.init(coder: aDecoder)
//        
//    }

    
    func heightForEntry(entry: DiaryEntry) -> CGFloat{
       
        let  topMargin: CGFloat = 35.0;
        let  bottomMargin: CGFloat = 80.0;
        let  minHeight: CGFloat = 106.0;

        var font: UIFont = UIFont.systemFontOfSize(UIFont.systemFontSize());
    
        var boundingBox: CGRect = entry.body.boundingRectWithSize(
            CGSizeMake(202, CGFloat.max), 
            options:(NSStringDrawingOptions.UsesLineFragmentOrigin),
            attributes: [NSFontAttributeName: font], context:nil);
        
//        let maximumLabelSize: CGSize = CGSizeMake(202, CGFloat.max)
//        let drawingOptions: NSStringDrawingOptions = .UsesFontLeading | .UsesLineFragmentOrigin
//        var boundingBox: CGRect = entry.body.boundingRectWithSize(maximumLabelSize,
//            options:drawingOptions,
//            attributes:attr,
//            context:nil);
        
        return max(minHeight, CGRectGetHeight(boundingBox) + topMargin + bottomMargin);
    }
    
    
    func configureCellForEntry(entry :DiaryEntry){
        
        println("EntryCell - configureCellForEntry");

        self.bodyLabel?.text = entry.body;
        println("entry.body \(entry.body)");
        println("self.bodyLabel?.text \(self.bodyLabel?.text)");
    
        //self.locationLabel?.text = entry.location;
        //println("entry.location \(entry.location)")
        //println("self.LocatoinLabel?.text \(self.locationLabel?.text)");

        
        var date: NSDate = NSDate(timeIntervalSince1970: entry.date);
        self.dateLabel?.text = DateformatterManager.dateFormatManager.stringFromDate(date);
        println("entry.date \(DateformatterManager.dateFormatManager.stringFromDate(date))");
        println("self.dateLabel?.text \(self.dateLabel?.text)");

//        if(entry.imageData){
//            self.mainImageView.image = UIImage(imageWithData:entry.imageData)
//        }else{
//
//        }

    }
}

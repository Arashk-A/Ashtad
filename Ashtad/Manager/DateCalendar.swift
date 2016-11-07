//
//  Calendar.swift
//  Ashtad
//
//  Created by Mohammad Ali on 10/9/16.
//  Copyright © 2016 Arashk. All rights reserved.
//

import Foundation
import Cocoa

class DateCalendar: NSObject {
    
    class func calendar() -> NSMutableAttributedString {
        let currentLanguage = StorageManager.currentLanguage
        let date: Date = Date()
        let formater: DateFormatter = DateFormatter()
        formater.locale = Locale(identifier: currentLanguage)
        
        let mycomponent = Calendar(identifier: StorageManager.getIdentifier(StorageManager.calendarTitle)!)
        formater.calendar = mycomponent
        
        formater.dateFormat = StorageManager.dayFormat
        let day = formater.string(from: date)
        
        formater.dateFormat = StorageManager.calendarDateFormat
        
        var dateString = NSString()
        
        for key in StorageManager.languageArray {
            if ((StorageManager.availableLanguage)[key as! String] as! Bool) {
                formater.calendar = Calendar(identifier: StorageManager.getIdentifier(key as! String)!)
                dateString = dateString.appendingFormat("%@\n   ", formater.string(from: date))
            }
        }
        
        dateString = dateString.trimmingCharacters(in: CharacterSet(charactersIn: "\n ")) as NSString
        
        let title = NSString.init(format: "%@\n   %@",day,dateString)
        let attributeTitle: NSMutableAttributedString = NSMutableAttributedString(string: title as String)
        
        let titleOptions: [String : AnyObject] = [
            NSFontAttributeName: StorageManager.calendarTitleFont,
            NSForegroundColorAttributeName: StorageManager.calendarTitleColor
        ]
        
        let subtitleOptions: [String : AnyObject] = [
            NSFontAttributeName: StorageManager.calendarSubtitleFont,
            NSForegroundColorAttributeName: StorageManager.calendarSubtitleColor
        ]
        
        attributeTitle.setAttributes(titleOptions, range: title.range(of: day))
        attributeTitle.setAttributes(subtitleOptions , range: title.range(of: dateString as String))
        
        if currentLanguage == persianLocale {
            attributeTitle.setAlignment(NSTextAlignment.right, range: title.range(of: title as String!))
        } else {
            attributeTitle.setAlignment(NSTextAlignment.left, range: title.range(of: title as String))
        }
        
        return attributeTitle
    }
    
    class func statusBarTitle() -> NSMutableAttributedString {
        let currentDate = Date()
        let myCalendar = Calendar(identifier: StorageManager.getIdentifier(StorageManager.calendarTitle)!)
        let currentDateComponents: DateComponents = (myCalendar as Calendar).dateComponents([.day], from: currentDate)
        
        let dayAttr: NSDictionary = [
            NSFontAttributeName: NSFont(name: "Lucida Grande", size: 14)!,
            NSForegroundColorAttributeName: SettingsManager.changeThemeColor()
        ]
        
        let str = NSString(format: "%ld", currentDateComponents.day!)
        let attributedTitle: NSMutableAttributedString = NSMutableAttributedString(string: str as String)
        
        
        attributedTitle.setAttributes(dayAttr as? [String : AnyObject], range: NSMakeRange(0, attributedTitle.length))
        
        return attributedTitle
    }
    
    class func timerAction(currentDate: Date) -> Bool {
        let calender1: DateComponents = (Calendar.current as Calendar).dateComponents([.year, .month, .day], from: Date())
        
        let calender2: DateComponents = (Calendar.current as Calendar).dateComponents([.year, .month, .day], from: currentDate)
        if calender1.year != calender2.year || calender1.month != calender2.month || calender1.day != calender2.day {
            return true
        } else {
            return false
        }
    }
    
}

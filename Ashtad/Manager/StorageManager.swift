//
//  StorageManager.swift
//  Ashtad
//
//  Created by Mohammad Ali on 10/8/16.
//  Copyright © 2016 Arashk. All rights reserved.
//

import Foundation
import  Cocoa

class StorageManager: NSObject {

    class var currentLanguage: String {
        get {
            if ((UserDefaults.standard.string(forKey: "currentLanguage")?.isEmpty) == nil) {
                let currentLanguage = englishLocale
                UserDefaults.standard.set(currentLanguage, forKey: "currentLanguage")
                UserDefaults.standard.synchronize()
                return currentLanguage
            } else {
                return UserDefaults.standard.string(forKey: "currentLanguage")!
            }
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "currentLanguage")
            UserDefaults.standard.synchronize()
        }
    }
    
    class var dayFormat: String {
        get {
            if UserDefaults.standard.string(forKey: "dayFormat") == nil {
                let dayFormat = "EEEE"
                UserDefaults.standard.set(dayFormat, forKey: "dayFormat")
                UserDefaults.standard.synchronize()
                return dayFormat
            } else {
                return UserDefaults.standard.string(forKey: "dayFormat")!
            }
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "dayFormat")
            UserDefaults.standard.synchronize()
        }
    }
    
    class var calendarDateFormat: String {
        get {
            if UserDefaults.standard.string(forKey: "calendarDateFormat") == nil {
                let calendarDateFormat = "MMMM d , YYYY"
                UserDefaults.standard.set(calendarDateFormat, forKey: "calendarDateFormat")
                UserDefaults.standard.synchronize()
                return calendarDateFormat
            } else {
                return UserDefaults.standard.string(forKey: "calendarDateFormat")!
            }
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "calendarDateFormat")
            UserDefaults.standard.synchronize()
        }
    }
    
    class var calendarTitle: String {
        get {
            if UserDefaults.standard.string(forKey: "itemTitle") == nil {
                let calendarTitle = "\(Calendar.Identifier.gregorian)"
                UserDefaults.standard.set(calendarTitle, forKey: "itemTitle")
                UserDefaults.standard.synchronize()
                return calendarTitle
            } else {
                return UserDefaults.standard.string(forKey: "itemTitle")!
            }
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "itemTitle")
            UserDefaults.standard.synchronize()
        }
    }
    
    class var languageArray: NSArray {
        get {
            return ["persian", "gregorian", "islamic"]
        }
    }
    
    class var availableLanguage: NSDictionary {
        get {
            if UserDefaults.standard.dictionary(forKey: "Available") == nil {
                let availableLanguage = ["persian": true, "gregorian": true, "islamic": false]
                UserDefaults.standard.set(availableLanguage, forKey: "itemTitle")
                UserDefaults.standard.synchronize()
                return availableLanguage as NSDictionary
            } else {
                return UserDefaults.standard.dictionary(forKey: "Available")! as NSDictionary
            }
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "Available")
            UserDefaults.standard.synchronize()
        }
    }
    
    class var calendarTitleFont: NSFont {
        get {
            if let fontName = UserDefaults.getFont("titleFont") {
                return fontName
            } else {
                return NSFont(name: "Lucida Grande", size: 14)!
            }
        }
        set {
            UserDefaults.setData(newValue, forKey: "titleFont")
        }
    }
    
    class var calendarSubtitleFont: NSFont {
        get {
            if let font = UserDefaults.getFont("subtitleFont") {
                return font
            } else {
                return NSFont(name: "Lucida Grande", size: 12)!
            }
        }
        set {
            UserDefaults.setData(newValue, forKey: "subtitleFont")
        }
    }
    
    class var calendarTitleColor: NSColor {
        get {
            if let color = UserDefaults.getColor("titleColor") {
                return color
            } else {
                return SettingsManager.changeThemeColor()
            }
        }
        set {
            UserDefaults.setData(newValue, forKey: "titleColor")
        }
    }
    
    class var calendarSubtitleColor: NSColor {
        get {
            if let color = UserDefaults.getColor("subtitleColor") {
                return color
            } else {
                return SettingsManager.changeThemeColor()
            }
        }
        set {
            UserDefaults.setData(newValue, forKey: "subtitleColor")
        }
    }
}

extension StorageManager {
    class func resetStorage() {
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
    }
    
    static func getIdentifier(_ id: String) -> Calendar.Identifier? {
        if id == "islamic" {
            return Calendar.Identifier.islamic
        }
        if id == "persian" {
            return Calendar.Identifier.persian
        }
        if id == "gregorian" {
            return Calendar.Identifier.gregorian
        }
        return Calendar.Identifier.gregorian
    }
}



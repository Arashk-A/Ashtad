//
//  SettingsManager.swift
//  Ashtad
//
//  Created by Mohammad Ali on 10/8/16.
//  Copyright © 2016 Arashk. All rights reserved.
//

import Foundation
import Cocoa

class SettingsManager: NSObject {
    class func checkOsxTemplate() -> Bool {
        if let _ = UserDefaults.standard.string(forKey: "AppleInterfaceStyle") {
            return true
        } else {
            return false
        }
    }
    
    class func relunch() {
        let task = Process()
        task.launchPath = "/bin/sh"
        task.arguments = ["-c", "open \"\(Bundle.main.bundlePath)\""]
        task.launch()
        
        NSApplication.shared().terminate(nil)
    }
    
    class func changeThemeColor() -> NSColor {
        if checkOsxTemplate() {
            return NSColor.white
        } else {
            return NSColor.black
        }
    }
}

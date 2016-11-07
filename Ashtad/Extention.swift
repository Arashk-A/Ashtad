//
//  Extention.swift
//  Ashtad
//
//  Created by Mohammad Ali on 5/8/16.
//  Copyright © 2016 Arashk. All rights reserved.
//

import Foundation
import Cocoa

extension UserDefaults {
    
    class func setData(_ newFont: AnyObject, forKey: String) {
        let data = NSKeyedArchiver.archivedData(withRootObject: newFont);
        UserDefaults.standard.set(data, forKey: forKey)
        UserDefaults.standard.synchronize()
    }
    
    class func getFont(_ key: String) -> NSFont? {
        let data = UserDefaults.standard.object(forKey: key) as? Data
        if let _ = data {
           return NSKeyedUnarchiver.unarchiveObject(with: data!) as? NSFont
        }
        return nil
    }
    
    class func getColor(_ key: String) -> NSColor? {
        let data = UserDefaults.standard.object(forKey: key) as? Data
        if let _ = data {
            return NSKeyedUnarchiver.unarchiveObject(with: data!) as? NSColor
        }
        return nil
     }
}

extension Bool {
    init<T : Integer>(_ integer: T){
        self.init(integer != 0)
    }
}

//
//  AutoLaunchHelper.swift
//  Ashtad
//
//  Created by Mohammad Ali on 4/7/16.
//  Copyright © 2016 Arashk. All rights reserved.
// This is a combination of the code provided by the following Stackoverflow discussion
// http://stackoverflow.com/questions/26475008/swift-getting-a-mac-app-to-launch-on-startup
// (This approach will not work with App-Sandboxing.)
//

import Foundation


class AutoLaunchHelper {
    
    static func applicationIsInStartUpItems() -> Bool {
        return (itemReferencesInLoginItems().existingReference != nil)
    }
    
    
    static func toggleLaunchAtStartup() {
        let itemReferences = itemReferencesInLoginItems()
        let shouldBeToggled = (itemReferences.existingReference == nil)
        let loginItemsRef = LSSharedFileListCreate(
            nil,
            kLSSharedFileListSessionLoginItems.takeRetainedValue(),
            nil
            ).takeRetainedValue() as LSSharedFileList?
        
        if loginItemsRef != nil {
            if shouldBeToggled {
                if let appUrl: CFURL = URL(fileURLWithPath: Bundle.main.bundlePath) as CFURL? {
                    LSSharedFileListInsertItemURL(loginItemsRef, itemReferences.lastReference, nil, nil, appUrl, nil, nil)
                    print("Application was added to login items")
                }
            } else {
                if let itemRef = itemReferences.existingReference {
                    LSSharedFileListItemRemove(loginItemsRef,itemRef);
                    print("Application was removed from login items")
                }
            }
        }
    }
    
    static func itemReferencesInLoginItems() -> (existingReference: LSSharedFileListItem?, lastReference: LSSharedFileListItem?) {
        let itemUrl = UnsafeMutablePointer<Unmanaged<CFURL>?>.allocate(capacity: 1)
        
        if let appUrl: URL = URL(fileURLWithPath: Bundle.main.bundlePath) {
            let loginItemsRef = LSSharedFileListCreate(
                nil,
                kLSSharedFileListSessionLoginItems.takeRetainedValue(),
                nil
                ).takeRetainedValue() as LSSharedFileList?
            
            if loginItemsRef != nil {
                let loginItems = LSSharedFileListCopySnapshot(loginItemsRef, nil).takeRetainedValue() as NSArray
                //                print("There are \(loginItems.count) login items")
                
                if(loginItems.count > 0) {
                    let lastItemRef = loginItems.lastObject as! LSSharedFileListItem
                    
                    for i in 0 ..< loginItems.count {
                        let currentItemRef = loginItems.object(at: i) as! LSSharedFileListItem
                        
                        if LSSharedFileListItemResolve(currentItemRef, 0, itemUrl, nil) == noErr {
                            if let urlRef: URL = itemUrl.pointee?.takeRetainedValue() as URL? {
                                //                                print("URL Ref: \(urlRef.lastPathComponent)")
                                if urlRef == appUrl {
                                    return (currentItemRef, lastItemRef)
                                }
                            }
                        }
                        else {
                            print("Unknown login application")
                        }
                    }
                    // The application was not found in the startup list
                    return (nil, lastItemRef)
                    
                } else  {
                    let addatstart: LSSharedFileListItem = kLSSharedFileListItemBeforeFirst.takeRetainedValue()
                    return(nil,addatstart)
                }
            }
        }
        
        return (nil, nil)
    }
}

//
//  AppDelegate.swift
//  AshtadHelper
//
//  Created by Mohammad Ali on 6/22/16.
//  Copyright © 2016 Arashk. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {


//    var alreadyRunning = false
//    var isActive = false
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
//        let running = NSWorkspace.sharedWorkspace().runningApplications
//        
//        for app in running {
//            if app.bundleIdentifier == "com.zero.Ashtad" {
//                alreadyRunning = true
//                isActive = app.active
//                print(app,app.active)
//            }
//        }
        
//        if !alreadyRunning {
            let path = NSBundle.mainBundle().bundlePath
            var e = path.componentsSeparatedByString("/")
            e.removeLast()
            e.removeLast()
            e.removeLast()
            e.removeLast()
//            e.append("MacOS")
//            e.append("Ashtad")
            NSWorkspace.sharedWorkspace().launchApplication(NSString.pathWithComponents(e))
//        }
        
//        let path = NSBundle.mainBundle().bundlePath
//        var e = path.componentsSeparatedByString("/")
//        e.removeLast()
//        e.removeLast()
//        e.removeLast()
//        e.removeLast()
//        NSWorkspace.sharedWorkspace().launchApplication(NSString.pathWithComponents(e))
        NSApp.terminate(nil)

    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    
    override func awakeFromNib() {
        let path = NSBundle.mainBundle().bundlePath
        print(path)
    }


}


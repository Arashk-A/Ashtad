//
//  AppDelegate.swift
//  Ashtad
//
//  Created by Mohammad Ali on 4/7/16.
//  Copyright © 2016 Arashk. All rights reserved.
//

import Cocoa

let persianLocale = "fa_IR"
let englishLocale = "en_US_POSIX"

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, NSMenuDelegate {
    
    @IBOutlet weak var menu: NSMenu!
    @IBOutlet weak var preferencesWindow: NSWindow!
    @IBOutlet weak var menuDateItem: NSMenuItem!
    @IBOutlet weak var close: NSButton!
    @IBOutlet weak var perferences: NSButton!
    
    internal var statusBar = NSStatusBar.system().statusItem(withLength: -1)
    internal var menuItem : NSMenuItem = NSMenuItem()
    
    internal var currentDate = Date()
    internal var timer = Timer()
    internal var currentLanguage = StorageManager.currentLanguage
    internal var isDark = SettingsManager.checkOsxTemplate()
    
    internal var dayFormat = StorageManager.dayFormat
    internal var calendarDateFormat = StorageManager.calendarDateFormat
    
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    override func awakeFromNib() {
        DistributedNotificationCenter.default().addObserver(self, selector: #selector(AppDelegate.themeChanged(_:)), name: NSNotification.Name(rawValue: "AppleInterfaceThemeChangedNotification"), object: nil)
        
        self.initMenu()
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(AppDelegate.fixTimer(_:)), userInfo: nil, repeats: true)

    }
    
    
    @IBAction func perferences(_ sender: AnyObject) {
        preferencesWindow.orderFront(sender)
        NSApp.activate(ignoringOtherApps: true)
    }
    
    @IBAction func close(_ sender: AnyObject) {
        StorageManager.currentLanguage = currentLanguage
        NSApp.terminate(self)
        
    }
    
    @objc fileprivate func timerAction(_ sender: AnyObject) {
        if DateCalendar.timerAction(currentDate: currentDate) {
            self.statusBarTitle()
        }
    }
    
    @objc fileprivate func fixTimer(_ sender: AnyObject) {
        let calendar = Calendar.current
        let components:DateComponents = (calendar as Calendar).dateComponents(
            [.hour, .minute, .second], from: Date())
        if components.second == 1 {
            timer.invalidate()
            timer = Timer.scheduledTimer(timeInterval: 60 , target: self, selector: #selector(AppDelegate.timerAction(_:)), userInfo: nil, repeats: true)
        }
    }
    
    fileprivate func statusBarTitle() {
        self.statusBar.attributedTitle = DateCalendar.statusBarTitle()
        self.menuDateItem.attributedTitle = DateCalendar.calendar()
    }
    
    fileprivate func isDarkMod() {
        if isDark {
            self.close.image = NSImage(named: "closeDarkMode")
            self.perferences.image = NSImage(named: "perferencesDarkMode")
        } else {
            self.close.image = NSImage(named: "close")
            self.perferences.image = NSImage(named: "perferences")
        }
    }
    
    @objc fileprivate func themeChanged(_ sender: AnyObject) {
        isDark = SettingsManager.checkOsxTemplate()
        isDarkMod()
        statusBarTitle()
    }

    fileprivate func initMenu() {
        statusBar.menu = menu
        statusBar.target = self
        menu.delegate = self
        statusBarTitle()
        isDarkMod()
    }
    
    func menuWillOpen(_ menu: NSMenu) {
        self.menuDateItem.attributedTitle = DateCalendar.calendar()
    }
    
}


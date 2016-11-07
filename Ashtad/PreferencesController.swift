//
//  PreferencesController.swift
//  Ashtad
//
//  Created by Mohammad Ali on 4/9/16.
//  Copyright © 2016 Arashk. All rights reserved.
//

import Cocoa
//import ServiceManagement

class PreferencesController: NSViewController {
    
    @IBOutlet weak var titleFontName: NSTextField!
    @IBOutlet weak var subtitleFontName: NSTextField!
    
    @IBOutlet weak var menuTitleMatrix: NSMatrix!
    
    @IBOutlet weak var titleFormat: NSTextField!
    @IBOutlet weak var dateFormat: NSTextField!
    
    @IBOutlet weak var showHijriCalendar: NSButton!
    @IBOutlet weak var setToStartUp: NSButton!
    
    @IBOutlet weak var showTitleColor: NSColorWell!
    @IBOutlet weak var showSubtitleColor: NSColorWell!
    
    @IBOutlet weak var menuLanguageMatrix: NSMatrix!
    
    fileprivate var selectedFontButton = ""
    internal var calendarTitle = StorageManager.calendarTitle
    internal var currentLanguage = StorageManager.currentLanguage
    override func awakeFromNib() {
        
        // add action to read font from NSFontPanel
        NSFontManager.shared().action = #selector(PreferencesController.fontSelector)
        self.initVariables()
        
    }
    
    fileprivate func showFontPanel() {
        let fontManeger = NSFontManager.shared()
        fontManeger.orderFrontFontPanel(self)
    }
    
    @objc fileprivate func fontSelector() {
        let fontManeger = NSFontManager.shared()
        fontManeger.target = self
        fontManeger.orderFrontFontPanel(self)

        let fontMenu = fontManeger.fontMenu(true)
        let oldFont = fontMenu!.font
        let newFont = fontManeger.convert(oldFont!)
        
        if selectedFontButton == "title" {
            titleFontName.stringValue = newFont.familyName!
            StorageManager.calendarTitleFont = newFont
            
        } else if selectedFontButton == "subtitle" {
            subtitleFontName.stringValue = newFont.familyName!
            StorageManager.calendarSubtitleFont = newFont
        }
    }

    @IBAction func relaunch(_ sender: NSButton) {
        SettingsManager.relunch()
    }
    
    
    @IBAction func changeTitleColor(_ sender: NSColorWell) {
        StorageManager.calendarTitleColor = sender.color as NSColor
    }
    
    @IBAction func changeSubtitleColor(_ sender: NSColorWell) {
        StorageManager.calendarSubtitleColor = sender.color as NSColor
    }
    
    @IBAction func changeTitleFont(_ sender: NSButton) {
        selectedFontButton = "title"
        showFontPanel()
    }
    
    @IBAction func changeSubtitleFont(_ sender: NSButton) {
        selectedFontButton = "subtitle"
        showFontPanel()
    }

    @IBAction func changeMenuTitle(_ sender: NSMatrix) {

        if menuTitleMatrix.selectedCell() == menuTitleMatrix.cell(atRow: 0, column: 0) {
            StorageManager.calendarTitle = "\(Calendar.Identifier.persian)"
        } else if menuTitleMatrix.selectedCell() == menuTitleMatrix.cell(atRow: 1, column: 0) {
             StorageManager.calendarTitle = "\(Calendar.Identifier.gregorian)"
        }
    }

    @IBAction func changeMenuLanguage(_ sender: NSMatrix) {
        if menuLanguageMatrix.selectedCell() == menuLanguageMatrix.cell(atRow: 0, column: 0) {
            StorageManager.currentLanguage = persianLocale
        } else if menuLanguageMatrix.selectedCell() == menuLanguageMatrix.cell(atRow: 1, column: 0) {
            StorageManager.currentLanguage = englishLocale
        }
    }

    @IBAction func setToStartup(_ sender: NSButton) {
        AutoLaunchHelper.toggleLaunchAtStartup()
    }
    
    @IBAction func addHijriCalendar(_ sender: NSButton) {
        var calender = StorageManager.availableLanguage as! [String: AnyObject]
        
        calender["islamic"] = Bool(showHijriCalendar.state) as AnyObject?
        StorageManager.availableLanguage = calender as NSDictionary
    }
    
    override func controlTextDidChange(_ obj: Notification) {
        if obj.object as? NSTextField == titleFormat {
            StorageManager.dayFormat = titleFormat.stringValue
        } else if obj.object as? NSTextField == dateFormat {
            StorageManager.calendarDateFormat = dateFormat.stringValue
        }
    }
    
    @IBAction func resetSetting(_ sender: NSButton) {
        StorageManager.resetStorage()
        SettingsManager.relunch()
    }
    
    
    fileprivate func initVariables() {
        currentLanguage == persianLocale ? menuLanguageMatrix.setState(1, atRow: 0, column: 0) : menuLanguageMatrix.setState(1, atRow: 1, column: 0)

        titleFontName.stringValue = StorageManager.calendarTitleFont.familyName!
        
        subtitleFontName.stringValue = StorageManager.calendarSubtitleFont.familyName!
        
        showTitleColor.color = StorageManager.calendarTitleColor

        showSubtitleColor.color = StorageManager.calendarSubtitleColor

        titleFormat.stringValue = StorageManager.dayFormat
        dateFormat.stringValue = StorageManager.calendarDateFormat
        
        
        setToStartUp.state = AutoLaunchHelper.applicationIsInStartUpItems() ? 1 : 0
        
        showHijriCalendar.state = ((StorageManager.availableLanguage)["islamic"] as! Bool) ? 1 : 0
        
        calendarTitle == "\(Calendar.Identifier.gregorian)" ? menuTitleMatrix.setState(1, atRow: 1, column: 0) : menuTitleMatrix.setState(1, atRow: 0, column: 0)
    }
}

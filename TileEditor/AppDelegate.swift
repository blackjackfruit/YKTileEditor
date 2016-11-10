//
//  AppDelegate.swift
//  TileEditor
//
//  Created by iury bessa on 10/28/16.
//  Copyright © 2016 yellokrow. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    @IBOutlet weak var openRecent: NSMenuItem?
    
    var vc: ViewController? = nil

    @IBAction func openDirectory(_ sender: AnyObject) {
        let myFileDialog: NSOpenPanel = NSOpenPanel()
        myFileDialog.runModal()
        if let path = myFileDialog.url?.path {
            self.loadFileWith(path: path)
            _ = self.recentFiles(addPath: path)
            addFilePathToRecentFiles(path: path)
        }
    }
    
    @IBAction func saveFile(_ sender: AnyObject) {
        guard let vc = vc else {
            return
        }
        
        let data = TileDataFormatter.nesTile(array: vc.getChangedTiles)
        _ = FileLoader.saveEditedFileTo(path: "/Users/yello/Documents/Dropbox/NES/src/git/demo_saved.chr", data: data!)
    }

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        vc = NSApplication.shared().mainWindow?.contentViewController as? ViewController
        vc?.update()
        
        if openRecent?.hasSubmenu != nil {
            var recentFiles = self.recentFiles(addPath: nil)
            if recentFiles.count >= 6 {
                let arraySlice = recentFiles[0..<6]
                recentFiles = Array(arraySlice)
            }
            for filePath in recentFiles {
                addFilePathToRecentFiles(path: filePath)
            }
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    func addFilePathToRecentFiles(path: String) {
        if openRecent?.hasSubmenu != nil {
            let subMenu = openRecent?.submenu
            let menuItem = NSMenuItem(title: path, action: #selector(loadRecentItemSelected(sender:)), keyEquivalent: "")
            subMenu?.addItem(menuItem)
        }
    }
    func recentFiles(addPath: String?) -> Array<String> {
        let userDefaults = UserDefaults.standard
        var list = userDefaults.object(forKey: "RecentFiles") as? Array<String>
        if list == nil {
            list = Array<String>()
        }
        
        if addPath != nil {
            list?.append(addPath!)
            userDefaults.set(list, forKey: "RecentFiles")
        }
        
        return list!
    }
    
    func loadRecentItemSelected(sender: NSMenuItem) {
        let filePathFromTitle = sender.title
        self.loadFileWith(path: filePathFromTitle)
    }
    
    func loadFileWith(path: String) {
        if path.characters.count == 0 {
            NSLog("File path is not valid")
            return
        }
        do {
            if let data: Data = try FileLoader.fileForEditing(path: path) {
                vc?.zoomSize = .x4
                
                if let nesTiles = TileDataFormatter.nesTile(data: data) {
                    vc?.arrayOfTiles = nesTiles
                    vc?.update()
                }
            } else {
                // TODO: some error
            }
        } catch {
            
        }
    }
}


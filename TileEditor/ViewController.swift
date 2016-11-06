//
//  ViewController.swift
//  TileEditor
//
//  Created by iury bessa on 10/28/16.
//  Copyright © 2016 yellokrow. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, TileEditorProtocol, PaletteSelectorProtocol, FileViewerProtocol {

    @IBOutlet weak var fileViewer: FileViewer?
    @IBOutlet var tileEditor: TileEditor?
    @IBOutlet weak var tileEditorSize: NSPopUpButtonCell?
    @IBOutlet var paletteSelection: PaletteSelector?
    @IBOutlet weak var tileViewerScrollView: NSScrollView?
    @IBOutlet weak var paletteGroups: PaletteOptions!
    @IBOutlet weak var colorSelection: PaletteOptions!
    
    var pixelData: [Int]? = nil
    var zoomSize: ZoomSize = .x4
    var tileDataFormatter: TileDataFormatter? = nil
    var tileDataType: TileDataType? = .NES
    var pixelsPerTile = 0
    var cursrorLocation: (x: Int, y: Int) = (0,0)
    var startingPosition = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        paletteSelection?.paletteSelectinoDelegate = self
        tileViewerScrollView?.contentView.scroll(to: NSMakePoint(0,0))
        
        fileViewer?.delegate = self
        fileViewer?.zoomSize = .x4
        
        tileEditor?.delegate = self
        tileEditor?.colorFromPalette = paletteSelection!.currentPalette
        tileEditor?.numberOfPixelsPerTile = 8
        tileEditor?.numberOfPixelsPerView = 8
        
        paletteGroups.needsDisplay = true
        colorSelection.needsDisplay = true
        //tileViewerScrollView?.backgroundColor = NSColor.clear
    }
    func update() {
        guard let tileDataType = tileDataType else {
            NSLog("Cannot call update without specifying needed parameters")
            return
        }
        
        switch tileDataType {
        case TileDataType.NES:
            pixelsPerTile = 8
        }
        
        tileEditor?.tiles = pixelData
        tileEditor?.numberOfPixelsPerTile = pixelsPerTile
        tileEditor?.numberOfPixelsPerView = Int(ZoomSize.x4.rawValue)*pixelsPerTile
        
        fileViewer?.tiles = pixelData
        fileViewer?.numberOfPixelsPerTile = pixelsPerTile
        fileViewer?.numberOfPixelsPerView = 128
        fileViewer?.selectionLocationVisible = true
        fileViewer?.updateView(zoomSize: zoomSize)
    }
    
    @IBAction func tileEditorSizeChanged(_ sender: NSPopUpButtonCell) {
        switch sender.indexOfSelectedItem {
        case 0:
            zoomSize = .x1
        case 1:
            zoomSize = .x2
        case 2:
            zoomSize = .x4
        default:
            zoomSize = .x8
        }

        fileViewer?.updateView(zoomSize: zoomSize)
    }
    //MARK: TileViewEditor Protocols
    func pixelDataChanged(pixelData: [Int:Int]) {
        guard let tileViewer = fileViewer else {
            NSLog("No tile viewer set")
            return
        }
        
//        let adjustedPixelData = translateEditorToViewerCoordinate(pixelData: pixelData,
//                                                                  editorTileCountHorizontally: Int(tileEditor!.zoomSize.rawValue),
//                                                                  viewerTileCountHorizontally: Int(fileViewer!.zoomSize.rawValue),
//                                                                  numberOfPixels: 8,
//                                                                  startingOffset: startingPosition)
        
        let didUpdateViewer = tileViewer.updateFileViewerWith(pixels: pixelData)
        NSLog("\(didUpdateViewer)")
    }
    func translateEditorToViewerCoordinate(pixelData: [Int:Int],
                                           editorTileCountHorizontally: Int,
                                           viewerTileCountHorizontally: Int,
                                           numberOfPixels: Int,
                                           startingOffset: Int) -> [Int:Int]{
        
        
        
        return [0:0]
    }
    
    //MARK: FileViewer Protocols
    internal func tilesSelected(tiles: [Int], startingPosition: Int, zoomSize: ZoomSize, x: Int, y: Int) {
        self.cursrorLocation.x = x
        self.cursrorLocation.y = y
        self.startingPosition = startingPosition
        
        tileEditor?.cursorLocation = (x, y)
        tileEditor?.numberOfPixelsPerView = Int(zoomSize.rawValue)*pixelsPerTile
        tileEditor?.zoomSize = zoomSize
        tileEditor?.startingPosition = startingPosition
        tileEditor?.update()
    }
    
    //MARK: PaletteSelection
    func paletteSelectionChanged(value: Int, paletteType: Int) {
        tileEditor?.colorFromPalette = value
    }
}


# TileEditor

[![Langues swift4](https://img.shields.io/badge/language-swift4-red.svg)](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/)
[![IDE Xcode9](https://img.shields.io/badge/IDE-Xcode9-blue.svg)](https://developer.apple.com/xcode/)
[![OS macOS](https://img.shields.io/badge/OS-macOS-brightgreen.svg)](https://www.apple.com)

TileEditor is a framework for creating and editing data files for nes graphics (CHR files) and roms on macOS. TileEditor was separated from the TileEditorPro application so to allow integration into other application (ConsoleIDE).

The TileEditor.framework has three apps which demonstrate the different facets of how to use the TileEditor framework. The three applications provide a simplification of palettes (color selection), pixel editor, and viewing nes graphics and roms.

Project is written using Swift4.

# Setup
To get this project to compile, cocoapods will be needed.
1. To install cocoapods easily, download Homebrew. Instructions for installing Homebrew can be found at https://brew.sh
2. Run the terminal command `brew install cocoapods`
3. Navigate to the project where you downloaded TileEditorPro and issue command `pod install`

### TODO:
* Add support for other platforms (gba, snes, genesis, etc.)
* More options for painting such as fill, square, lines, etc.
* Need to write Unit Tests.

//  Copyright (c) 2016 Roberto Pastor <roberto.pastor.ortiz@gmail.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Foundation

#if os(iOS) || os(tvOS) || os(watchOS)
  import UIKit
  public typealias Color = UIColor
#else
  import AppKit
  public typealias Color = NSColor
#endif

// MARK: - String extension

extension String {
  public var color: Color? {
    let hex = self.stringByTrimmingCharactersInSet(NSCharacterSet.alphanumericCharacterSet().invertedSet)
    return hexToColor(hex)
  }
}

// MARK: - Color extension

extension Color {
  
  /**
   Convenience initializer using a hex code string.
   
   - parameter hex: hexadecimal color code (supports 3, 6 and 8 length codes)
   
   - returns: A UIColor or NSColor instance deppending of platform
   */
  public convenience init?(hex:String) {
    
    guard let (alpha, red, green, blue) = hexStringToRGBATuple(hex) else {
      return nil
    }
    self.init(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: CGFloat(alpha) / 255)
  }
  
  /**
   RED component of the color in CGFloat format
   
   - returns: RED color component in CGFloat format
   */
  public func red() -> CGFloat? {
    var fRed:CGFloat = 0
    
    if self.getRed(&fRed, green:nil, blue:nil, alpha:nil) == true {
      return fRed
    } else {
      return nil
    }
  }
  
  /**
   RED component hex code in string format
   
   - returns: RED color component hex code in string format
   */
  public func redHex() -> String? {
    
    if let fRed = self.red() {
      return String(format:"%2X", Int(fRed * 255.0))
    }
    return nil
  }
  
  /**
   GREEN component of the color in CGFloat format
   
   - returns: GREEN color component in CGFloat format
   */
  public func green() -> CGFloat? {
    var fGreen:CGFloat = 0
    
    if self.getRed(nil, green:&fGreen, blue:nil, alpha:nil) {
      return fGreen
    } else {
      return nil
    }
  }
  
  /**
   GREEN component hex code in string format
   
   - returns: GREEN color component hex code in string format
   */
  public func greenHex() -> String? {
    if let fGreen = self.green() {
      return String(format:"%2X", Int(fGreen * 255.0))
    }
    return nil
  }
  
  /**
   BLUE component of the color in CGFloat format
   
   - returns: BLUE color component in CGFloat format
   */
  public func blue() -> CGFloat? {
    var fBlue:CGFloat = 0
    
    if self.getRed(nil, green:nil, blue:&fBlue, alpha:nil) {
      return fBlue
    } else {
      return nil
    }
  }
  
  /**
   BLUE component hex code in string format
   
   - returns: BLUE color component hex code in string format
   */
  public func blueHex() -> String? {
    if let fBlue = self.blue() {
      return String(format:"%2X", Int(fBlue * 255.0))
    }
    return nil
  }
  
  
  public func hex() -> String? {
    
    if let redHex = self.redHex(), let greenHex = self.greenHex(), let blueHex = self.blueHex() {
      return redHex + greenHex + blueHex
    }
    
    return nil
  }
  
  
  /**
   ALPHA component of the color in CGFloat format (from 0.0 to 1.0)
   
   - returns: ALPHA component in CGFloat format
   */
  public func alpha() -> CGFloat? {
    var fAlpha:CGFloat = 0
    
    if self.getRed(nil, green: nil, blue: nil, alpha: &fAlpha) {
      return fAlpha
    } else {
      return nil
    }
  }
  
  /**
   HUE component of the color in CGFloat format (from 0.0 to 1.0)
   
   - returns: HUE component in CGFloat format
   */
  public func hue() -> CGFloat? {
    var fHue:CGFloat = 0
    
    if self.getHue(&fHue, saturation: nil, brightness: nil, alpha: nil) {
      return fHue
    } else {
      return nil
    }
  }

  /**
   SATURATION component of the color in CGFloat format (from 0.0 to 1.0)
   
   - returns: SATURATION component in CGFloat format
   */
  public func saturation() -> CGFloat? {
    var fSaturation:CGFloat = 0
    
    if self.getHue(nil, saturation: &fSaturation, brightness: nil, alpha: nil) {
      return fSaturation
    } else {
      return nil
    }
  }

  /**
   BRIGHTNES component of the color in CGFloat format (from 0.0 to 1.0)
   
   - returns: BRIGHTNESS component in CGFloat format
   */
  public func brightness() -> CGFloat? {
    var fBrightness:CGFloat = 0
    
    if self.getHue(nil, saturation: nil, brightness: &fBrightness, alpha: nil) {
      return fBrightness
    } else {
      return nil
    }
  }
}


/**
 Helper private function to transform hex code into color object.
 
 - parameter hex: hexadecimal color code (supports 3, 6 and 8 length codes)
 
 - returns: A UIColor or NSColor instance deppending of platform
 */
func hexToColor(hex: String) -> Color? {
  
  if let (alpha, red, green, blue) = hexStringToRGBATuple(hex) {
    return Color(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: CGFloat(alpha) / 255)
  }
  
  return nil
}


/**
 Helper private function to transform hex code into RGBA components tuple.
 
 - parameter hex: hexadecimal color code (supports 3, 6 and 8 length codes)
 
 - returns: tuple with RGBAComponents (Red, Green, Blue, Alpha)
 */
func hexStringToRGBATuple(hex:String) -> (UInt32, UInt32, UInt32, UInt32)? {
  
  var int = UInt32()
  guard NSScanner(string: hex).scanHexInt(&int) else {
    return nil
  }
  
  switch hex.characters.count {
  case 3: // RGB (12-bit)
    return (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
  case 6: // RGB (24-bit)
    return (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
  case 8: // ARGB (32-bit)
    return (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
  default:
    return nil
  }
  
}
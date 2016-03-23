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
  public convenience init(hex:String) {
    
    guard let (alpha, red, green, blue) = hexStringToRGBATuple(hex) else {
      self.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
      return
    }
    
    self.init(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: CGFloat(alpha) / 255)
  }
  
  /**
   RED component of the color in CGFloat format
   
   - returns: RED color component in CGFloat format
   */
  public func red() -> CGFloat {
    var fRed:CGFloat = 0
    self.getRed(&fRed, green:nil, blue:nil, alpha:nil)
    return fRed
  }
  
  /**
   RED component hex code in string format
   
   - returns: RED color component hex code in string format
   */
  public func redHex() -> String {
    return String(format:"%02X", Int(self.red() * 255.0))
  }
  
  /**
   GREEN component of the color in CGFloat format
   
   - returns: GREEN color component in CGFloat format
   */
  public func green() -> CGFloat {
    var fGreen:CGFloat = 0
    self.getRed(nil, green:&fGreen, blue:nil, alpha:nil)
    return fGreen
  }
  
  /**
   GREEN component hex code in string format
   
   - returns: GREEN color component hex code in string format
   */
  public func greenHex() -> String {
    return String(format:"%02X", Int(self.green() * 255.0))
  }
  
  /**
   BLUE component of the color in CGFloat format
   
   - returns: BLUE color component in CGFloat format
   */
  public func blue() -> CGFloat {
    var fBlue:CGFloat = 0
    self.getRed(nil, green:nil, blue:&fBlue, alpha:nil)
    return fBlue
  }
  
  /**
   BLUE component hex code in string format
   
   - returns: BLUE color component hex code in string format
   */
  public func blueHex() -> String {
    return String(format:"%02X", Int(self.blue() * 255.0))
  }
  
  
  public func hex() -> String {
    return self.redHex() + self.greenHex() + self.blueHex()
  }
  
  
  /**
   ALPHA component of the color in CGFloat format (from 0.0 to 1.0)
   
   - returns: ALPHA component in CGFloat format
   */
  public func alpha() -> CGFloat {
    var fAlpha:CGFloat = 0
    self.getRed(nil, green: nil, blue: nil, alpha: &fAlpha)
    return fAlpha
  }
  
  /**
   HUE component of the color in CGFloat format (from 0.0 to 1.0)
   
   - returns: HUE component in CGFloat format
   */
  public func hue() -> CGFloat {
    var fHue:CGFloat = 0
    self.getHue(&fHue, saturation: nil, brightness: nil, alpha: nil)
    return fHue
  }

  /**
   SATURATION component of the color in CGFloat format (from 0.0 to 1.0)
   
   - returns: SATURATION component in CGFloat format
   */
  public func saturation() -> CGFloat {
    var fSaturation:CGFloat = 0
    self.getHue(nil, saturation: &fSaturation, brightness: nil, alpha: nil)
    return fSaturation
  }

  /**
   BRIGHTNES component of the color in CGFloat format (from 0.0 to 1.0)
   
   - returns: BRIGHTNESS component in CGFloat format
   */
  public func brightness() -> CGFloat {
    var fBrightness:CGFloat = 0
    self.getHue(nil, saturation: nil, brightness: &fBrightness, alpha: nil)
    return fBrightness
  }
  
  /**
   Inverse Color
   
   - returns: Inverse color for this instance
   */
  public func inverse() -> Color {
    var r:CGFloat = 0.0, g:CGFloat = 0.0, b:CGFloat = 0.0, a:CGFloat = 0.0
    self.getRed(&r, green: &g, blue: &b, alpha: &a)
    return Color(red: 1.0 - r, green: 1.0 - g, blue: 1.0 - b, alpha: 1.0 - a)
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
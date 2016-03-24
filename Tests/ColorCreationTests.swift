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

import RPColor
import Foundation
import XCTest

class ColorCreationTests: XCTestCase {
  
  let controlColor = Color(red: CGFloat(255/255), green: (0/255), blue: (0/255), alpha: 1)
  
  func testColorCreationWithRGB() {
    let colorRGB = Color(hex: "F00")
    
    XCTAssertEqual(controlColor, colorRGB, "Color created with RGB hex code is wrong")
    
  }
  
  func testColorCreationWithRRGGBB() {
    let colorRRGGBB = Color(hex: "FF0000")
    
    XCTAssertEqual(controlColor, colorRRGGBB, "Color created with RRGGBB hex code is wrong")
  }
  
  func testColorCreationWithAARRGGBB() {
    let colorAARRGGBB = Color(hex: "FFFF0000")
    
    XCTAssertEqual(controlColor, colorAARRGGBB, "Color created with AARRGGBB hex code is wrong")
  }
  
  func testColorCreationWithInvalidHexCode() {
    let colorInvalid = Color(hex: "THIS IS A BAD COLOR HEX STRING")
    
    XCTAssertEqual(colorInvalid.alpha(), 0, "Color created with invalid hex code should be clear Color")
  }
  
}
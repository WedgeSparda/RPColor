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

class ColorRGBComponentsTests: XCTestCase {
  
  let controlColor = Color(hex: "F3F2F1")
  
  func testRedComponentIsCorrect() {
    XCTAssertEqual(controlColor?.redHex(), "F3", "Red component of color is wrong")
  }

  func testGreenComponentIsCorrect() {
    XCTAssertEqual(controlColor?.greenHex(), "F2", "Green component of color is wrong")
  }
  
  func testBlueComponentIsCorrect() {
    XCTAssertEqual(controlColor?.blueHex(), "F1", "Blue component of color is wrong")
  }
  
  func testAlphaComponentIsCorrect() {
    XCTAssertEqual(controlColor?.alpha(), 1.0, "Alpha component of color is wrong")
  }
  
  func testHexCodeIsCorrect() {
    XCTAssertEqual(controlColor?.hex(), "F3F2F1", "Color hex code is wrong")
  }
}


class ColorHSBComponentsTests: XCTestCase {
 
  let controlColor = Color(hue: 0.7, saturation: 0.7, brightness: 0.7, alpha: 1.0)
  
  func testHueComponentIsCorrect() {
    XCTAssertEqualWithAccuracy(controlColor.hue()!, CGFloat(0.7), accuracy: 0.1, "Hue component of color is wrong")
  }
  
  func testSaturationComponentIsCorrect() {
    XCTAssertEqualWithAccuracy(controlColor.saturation()!, CGFloat(0.7), accuracy: 0.1, "Saturation component of color is wrong")
  }
  
  func testBrightnessComponentIsCorrect() {
    XCTAssertEqualWithAccuracy(controlColor.brightness()!, CGFloat(0.7), accuracy: 0.1, "Brightness component of color is wrong")
  }
}

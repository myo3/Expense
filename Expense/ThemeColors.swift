//
//  ThemeColors.swift
//  Expense
//
//  Created by Monica Ong on 1/22/16.
//  Copyright © 2016 Monica Ong. All rights reserved.
//

import UIKit

enum Color: String{
    case Green, Teal, Orange, Purple, Pink, Yellow, Red, Blue, Turquiose, Beige, Dark_Brown, Light_Brown, White, Off_White
}

enum Shade: String{
    case Dark, Light
}
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}


/*
* ThemeColors holds all the app's colors
* Intialize ThemeColors to access apps color (no need to pass themeColor from VC to VC)
*/
class ThemeColors: NSObject {
    
    //Color
    var colorPalette: [Color: UIColor] = [.Green : UIColor(netHex:0x7BD33E), .Teal : UIColor(netHex: 0x3DCDCC), .Orange : UIColor(netHex: 0xFD8E62), .Purple : UIColor(netHex: 0xA364D8), .Pink : UIColor(netHex: 0xE2679A), .Yellow : UIColor(netHex: 0xF2DA5E), .Red : UIColor(netHex: 0xEE6E5D), .Blue : UIColor(netHex: 0x0D9FD8), .Turquiose : UIColor(netHex: 0x1CCCAC), .Beige : UIColor(netHex: 0xE7DDD4), .Dark_Brown : UIColor(netHex: 0x6F6559), .Light_Brown : UIColor(netHex: 0xAB9D89), .White : UIColor.whiteColor(), .Off_White : UIColor(netHex: 0xFBF9F7)]
    private var colorOfDay: [Day: UIColor] = [Day: UIColor]()
    private var themeTintColor: UIColor?
    private var backgroundColor: UIColor?
    private var fontDarkColor: UIColor? //fontColor
    private var fontLightColor: UIColor? //fontHightlightColor
    private var viewBackgroundColor: UIColor? //offWhite
    
    override init() {
        //set up theme colors
        themeTintColor = colorPalette[.Turquiose]
        
        backgroundColor = colorPalette[.Beige]
        viewBackgroundColor = colorPalette[.Off_White]
        
        fontDarkColor =  colorPalette[.Dark_Brown]
        fontLightColor = colorPalette[.Light_Brown]
        
         colorOfDay = [.Mon: colorPalette[.Green]!, .Tue: colorPalette[.Teal]!, .Wed: colorPalette[.Orange]!, .Thu: colorPalette[.Purple]!, .Fri: colorPalette[.Pink]!, .Sat: colorPalette[.Yellow]!, .Sun: colorPalette[.Red]!]

        
    }
    
    func getThemeTintColor() -> UIColor{
        return themeTintColor!
    }
    
    func getBackgroundColor() -> UIColor{
        return backgroundColor!
    }
    
    func getFontColor(shade: Shade) -> UIColor{
        if shade == .Light{
            return fontLightColor!
        } else{
            return fontDarkColor!
        }
    }
    
    func getViewBackgroundColor() -> UIColor{
        return viewBackgroundColor!
    }
    
    func getColorOfDay(day: Day) -> UIColor{
        return colorOfDay[day]!
    }
    
}

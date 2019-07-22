//
//  UIColorHex.swift
//  HomeModule
//
//  Created by ZZJ on 2019/7/22.
//

import UIKit

extension UIColor {
    /**
     Make color with hex string
     - parameter hex: 16进制字符串
     - returns: RGB
     */
    static func hexString (hex: String) -> UIColor {
        
        return UIColor.hexString(hex: hex, alpha: 1.0)
    }
    static func hexString (hex: String,alpha: CGFloat) -> UIColor {
        
        var cString: String = hex.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
        
        if cString.hasPrefix("#") {
            cString = String(cString[cString.index(cString.startIndex, offsetBy: 1)..<cString.endIndex])
            
        }else if cString.hasPrefix("0x") {
            cString = String(cString[cString.index(cString.startIndex, offsetBy: 1)..<cString.endIndex])
        }
        
        if (cString.count != 6) {
            return UIColor.gray
        }
        
        let rString = String(cString[cString.startIndex...cString.index(cString.startIndex, offsetBy: 1)])
        
        let gString = String(cString[cString.index(cString.startIndex, offsetBy: 2)...cString.index(cString.startIndex, offsetBy: 3)])
        
        let bString = String(cString[cString.index(cString.startIndex, offsetBy: 4)...cString.index(cString.startIndex, offsetBy: 5)])
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
    }
}

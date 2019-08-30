//
//  StringExtension.swift
//  TCMBase
//
//  Created by ZZJ on 2019/8/8.
//

import Foundation

extension NSObject {
    func stringForClass(_ obj: Any) -> String {
        let vaule = type(of: obj as Any)
        var valueStr = "\(vaule)"
        if valueStr.contains(".") {
            let strArray = valueStr.components(separatedBy: ".")
            valueStr = strArray[strArray.startIndex]
        }
        return valueStr
    }
}

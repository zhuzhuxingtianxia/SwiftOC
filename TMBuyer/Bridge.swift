//
//  Bridge.swift
//  TMBuyer
//
//  Created by ZZJ on 2019/7/18.
//  Copyright © 2019 Jion. All rights reserved.
//

import Foundation
import UIKit

/*
 OC:
 id objc = [Bridge getInstanllWithTarget:@"HomeModule.CenterViewController"];
 
 objc = [Bridge getInstanllWithTarget:@"" bundleSpace:@""];
 
 */

@objcMembers class Bridge: NSObject {
    
    class func getInstanll(target: String)-> UIViewController? {
        let name = Bundle.main.object(forInfoDictionaryKey: "CFBundleExecutable")as! String
        return self.getInstanll(target: target, bundleSpace: name)
        
    }
    
    class func getInstanll(target: String, bundleSpace: String?) -> UIViewController? {
        var className = target
        
        if !target.contains(".") {
            className = bundleSpace! + "." + target
        }
        
        let classType = NSClassFromString(className) as? UIViewController.Type
        if let cls = classType {
            return cls.init()
        }else{
            return nil
        }
        
        
    }

    public func foo() {
        print("xxxx")
    }
}

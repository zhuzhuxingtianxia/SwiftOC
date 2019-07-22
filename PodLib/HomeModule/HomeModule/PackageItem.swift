//
//  PackageItem.swift
//  HomeModule
//
//  Created by ZZJ on 2019/7/20.
//

import UIKit

class PackageItem: UIControl {
   private var topLable:UILabel = {
       let redPackageLabel = UILabel.init()
        redPackageLabel.font = UIFont.systemFont(ofSize: 15)
        redPackageLabel.textColor = UIColor.init(red: 245/255.0, green: 45/255.0, blue: 91/255.0, alpha: 1.0)
        redPackageLabel.textAlignment = .center
        redPackageLabel.text = "0"
        
        return redPackageLabel
    }()
    
   private var bottomLabel:UILabel = {
        let packageLabel = UILabel.init()
        packageLabel.font = UIFont.systemFont(ofSize: 15)
        packageLabel.textColor = UIColor.init(red: 51/255.0, green: 51/255.0, blue: 51/255.0, alpha: 1.0)
        packageLabel.text = "红包卡券"
        packageLabel.textAlignment = .center
        
        return packageLabel
    }()
    
    public var topTitle:String {
        set {
            topLable.text = newValue
        }
        get {
            return topLable.text ?? ""
        }
    }
    
    public var bottomTitle:String {
        set {
            bottomLabel.text = newValue
        }
        get {
            return bottomLabel.text ?? ""
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(topLable)
        addSubview(bottomLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        topLable.frame = CGRect.init(x: 0, y: 0, width: frame.size.width, height: frame.size.height/2.0)
        bottomLabel.frame = CGRect.init(x: 0, y: topLable.frame.maxY, width: frame.size.width, height: frame.size.height/2.0)
    }
}

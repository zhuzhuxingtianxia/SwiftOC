//
//  ButtonImagePosition.swift
//  HomeModule
//
//  Created by ZZJ on 2019/7/22.
//

import UIKit

//MARK: -定义button相对label的位置
public enum ImageAlignmentStyle : Int {
    case Top
    case Left
    case Right
    case Bottom
}

extension UIButton {

    open func layoutButton(style: ImageAlignmentStyle, space: CGFloat) {
        //得到imageView和titleLabel的宽高
        let imageWidth = imageView?.frame.size.width
        let imageHeight = imageView?.frame.size.height
        
        var labelWidth: CGFloat! = 0.0
        var labelHeight: CGFloat! = 0.0
        
        labelWidth = titleLabel?.intrinsicContentSize.width
        labelHeight = titleLabel?.intrinsicContentSize.height
        
        //初始化imageEdgeInsets和labelEdgeInsets
        var imageEdgeInsets = UIEdgeInsets.zero
        var labelEdgeInsets = UIEdgeInsets.zero
        
        //根据style和space得到imageEdgeInsets和labelEdgeInsets的值
        switch style {
        case .Top:
            //上 左 下 右
            imageEdgeInsets = UIEdgeInsets(top: -labelHeight-space/2, left: 0, bottom: 0, right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth!, bottom: -imageHeight!-space/2, right: 0)
            break;
            
        case .Left:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -space/2, bottom: 0, right: space)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: space/2, bottom: 0, right: -space/2)
            break;
            
        case .Bottom:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -labelHeight!-space/2, right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets(top: -imageHeight!-space/2, left: -imageWidth!, bottom: 0, right: 0)
            break;
            
        case .Right:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: labelWidth+space/2, bottom: 0, right: -labelWidth-space/2)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth!-space/2, bottom: 0, right: imageWidth!+space/2)
            break;
            
        }
        
        self.titleEdgeInsets = labelEdgeInsets
        self.imageEdgeInsets = imageEdgeInsets
        
    }
   
    
}

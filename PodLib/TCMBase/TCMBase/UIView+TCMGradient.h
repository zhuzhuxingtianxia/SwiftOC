//
//  UIView+TCMGradient.h
//  Buyer
//
//  Created by ZZJ on 2018/8/17.
//  Copyright © 2018年 Taocaimall Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, GradientDirection) {
    GradientTopToBottom = 0,            //从上到下
    GradientLeftToRight,                //从左到右
    GradientLeftTopToRightBottom,       //从左上到右下
    GradientLeftBottomToRightTop        //从左下到右上
};
@interface UIView (TCMGradient)
//颜色数组
@property(nullable, copy) NSArray *colors;
//渐变范围[0,1]
@property(nullable, copy) NSArray<NSNumber *> *locations;
//开始和结束点[0,0]-[1,1]
@property CGPoint startPoint;
@property CGPoint endPoint;

/*
 支持两种渐变色
 */
- (UIView *)gradientFromColor:(UIColor *)fromColor toColor:(UIColor *)toColor directionType:(GradientDirection)direction;
//自定义渐变
- (void)gradientWithColors:(NSArray<UIColor *> *)colors locations:(NSArray<NSNumber *> *)locations startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;

@end

//
//  UIView+TransformPI.h
//  Buyer
//
//  Created by ZZJ on 2018/3/29.
//  Copyright © 2018年 Taocaimall Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (TransformPI)

/**
 对view的layer做180度旋转，没有动画效果
 不设置或为NO这为原来的视图
 */
@property(nonatomic,assign)BOOL  isTransformPI;
/**
 对view做180度旋转
 
 @param animation 是否动画
 */
-(void)transformPIAnimation:(BOOL)animation;
/**
 对view做90度旋转
 
 @param animation 是否动画
 */
-(void)transformPI_2Animation:(BOOL)animation;

/**
 视图旋转，若处于复位（或默认）状态则旋转，否则则复位
 
 @param angle 旋转的角度
 */
-(void)transformViewAngle:(CGFloat)angle;
/**
 动画翻转，从上到下

 @param rotate YES从上倒下，NO从下到上
 */
- (void)transformRotateFromTopToBottomOrNo:(BOOL)rotate;

@end

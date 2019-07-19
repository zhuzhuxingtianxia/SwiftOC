//
//  UICollectionReusableView+TCMLayer.m
//  TCMDemo
//
//  Created by ZZJ on 2018/2/3.
//  Copyright © 2018年 Taocaimall Inc. All rights reserved.
//

#import "UICollectionReusableView+TCMLayer.h"

@implementation ZPositionZeroLayer
- (CGFloat)zPosition {
    return 0;
}
@end

@implementation UICollectionReusableView (TCMLayer)

+ (Class)layerClass {
    return[ZPositionZeroLayer class];
}

@end

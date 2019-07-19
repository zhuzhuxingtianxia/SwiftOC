//
//  UIView+TCMGradient.m
//  Buyer
//
//  Created by ZZJ on 2018/8/17.
//  Copyright © 2018年 Taocaimall Inc. All rights reserved.
//

#import "UIView+TCMGradient.h"
#import <objc/runtime.h>

@implementation UIView (TCMGradient)
+ (Class)layerClass {
    return [CAGradientLayer class];
}
- (UIView *)gradientFromColor:(UIColor *)fromColor toColor:(UIColor *)toColor directionType:(GradientDirection)direction {
    if (fromColor && toColor) {
        CGPoint startPoint = CGPointMake(0, 0);
        CGPoint endPoint = CGPointMake(0, 1.0);
        
        switch (direction) {
            case GradientLeftToRight:
                {
                    startPoint = CGPointMake(0, 0);
                    endPoint = CGPointMake(1.0, 0);
                }
                break;
            case GradientLeftTopToRightBottom:
            {
                startPoint = CGPointMake(0, 0);
                endPoint = CGPointMake(1.0, 1.0);
            }
                break;
            case GradientLeftBottomToRightTop:
            {
                startPoint = CGPointMake(0, 1.0);
                endPoint = CGPointMake(1.0, 0);
            }
                break;
                
            default:
                break;
        }
        
        [self gradientWithColors:@[fromColor,toColor] locations:@[@0,@1] startPoint:startPoint endPoint:endPoint];
    }
    return self;
}
- (void)gradientWithColors:(NSArray<UIColor *> *)colors locations:(NSArray<NSNumber *> *)locations startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint {
    NSMutableArray *colorsM = [NSMutableArray array];
    for (UIColor *color in colors) {
        [colorsM addObject:(__bridge id)color.CGColor];
    }
    self.colors = [colorsM copy];
    self.locations = locations;
    self.startPoint = startPoint;
    self.endPoint = endPoint;
}

#pragma mark- Getter&Setter

- (NSArray *)colors {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setColors:(NSArray *)colors {
    objc_setAssociatedObject(self, @selector(colors), colors, OBJC_ASSOCIATION_COPY_NONATOMIC);
    if ([self.layer isKindOfClass:[CAGradientLayer class]]) {
        if ([self isKindOfClass:[UILabel class]]) {
            self.backgroundColor = [UIColor clearColor];
        }
        [((CAGradientLayer *)self.layer) setColors:self.colors];
    }
}

- (NSArray<NSNumber *> *)locations {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setLocations:(NSArray<NSNumber *> *)locations {
    objc_setAssociatedObject(self, @selector(locations), locations, OBJC_ASSOCIATION_COPY_NONATOMIC);
    if ([self.layer isKindOfClass:[CAGradientLayer class]]) {
        [((CAGradientLayer *)self.layer) setLocations:self.locations];
    }
}
- (CGPoint)startPoint {
    return [objc_getAssociatedObject(self, _cmd) CGPointValue];
}

- (void)setStartPoint:(CGPoint)startPoint {
    objc_setAssociatedObject(self, @selector(startPoint), [NSValue valueWithCGPoint:startPoint], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([self.layer isKindOfClass:[CAGradientLayer class]]) {
        [((CAGradientLayer *)self.layer) setStartPoint:self.startPoint];
    }
}

- (CGPoint)endPoint {
    return [objc_getAssociatedObject(self, _cmd) CGPointValue];
}

- (void)setEndPoint:(CGPoint)endPoint {
    objc_setAssociatedObject(self, @selector(endPoint), [NSValue valueWithCGPoint:endPoint], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([self.layer isKindOfClass:[CAGradientLayer class]]) {
        [((CAGradientLayer *)self.layer) setEndPoint:self.endPoint];
    }
}

@end

@implementation UILabel (Gradient)

+ (Class)layerClass {
    return [CAGradientLayer class];
}

@end

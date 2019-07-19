//
//  WXPickerModule+Event.m
//  AFNetworking
//
//  Created by ZZJ on 2018/12/5.
//

#import <objc/runtime.h>
#import "WXPickerModule+Event.h"
@interface WXPickerModule (Private)
@property(nonatomic,strong)UIView *backgroundView;
@end

@implementation WXPickerModule (Event)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class className = [self class];
        
        SEL originalSelector = @selector(show);
        SEL swizzledSelector = @selector(replace_show);
        
        Method originalMethod = class_getInstanceMethod(className, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(className, swizzledSelector);
        
        BOOL didAddMethod = class_addMethod(className, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (didAddMethod) {
            class_replaceMethod(className, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        }else{
            //交换实现
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
        
    });
}

//交换的方法
-(void)replace_show {
    NSString *version = [UIDevice currentDevice].systemVersion;
    if ([version rangeOfString:@"."].location != NSNotFound) {
        NSArray *versions = [version componentsSeparatedByString:@"."];
        if ([versions.firstObject integerValue] == 11) {
            NSArray *gestureRecognizers = self.backgroundView.gestureRecognizers;
            if (gestureRecognizers.count > 0) {
                [self.backgroundView removeGestureRecognizer:gestureRecognizers.lastObject];
                UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:NSSelectorFromString(@"hide")];
                tapGesture.delegate = self;
                [self.backgroundView addGestureRecognizer:tapGesture];
            }
        }
    }
    
    [self replace_show];
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    Ivar backgroundViewivar = class_getInstanceVariable([self class], "_backgroundView");
    UIView *backgroundView=object_getIvar(self, backgroundViewivar);
    if (touch.view==backgroundView) {
        
        return YES;
        
    }
    return NO;
}

@end

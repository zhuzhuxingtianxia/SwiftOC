//
//  TCMWeex.m
//  Weex
//
//  Created by Dao on 2018/1/9.
//  Copyright © 2018年 Taocaimall. All rights reserved.
//

#import "TCMWeex.h"

#import "WeexSDK.h"
#import "TCMWeexImageLoader.h"
#import "tHybridModulesLoader.h"
#import "thybridNavigationDefaultImpl.h"
#import "UIViewController+tHybridWeex.h"
#import "NSURL+tHybrid.h"

NSString *const tHybrid_remote_filepath_key = @"filepath";

@implementation tHybridKit
BOOL _Thybrid_Kit_Network_Working_ = NO;
BOOL _Thybrid_Kit_Iphone_X_ = NO;

+ (void)launchingWeex{

    [self initDeviceEnvironment];

#if DEBUG
    [WXLog setLogLevel:WXLogLevelLog];
#else
    [WXLog setLogLevel:WXLogLevelOff];
#endif

    [WXAppConfiguration setAppGroup:@"Taocaimall"];
    [WXAppConfiguration setAppName:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"TCMStatisticsClientName"]];

    [WXAppConfiguration setAppVersion:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];

    //初始化环境
    [WXSDKEngine initSDKEnvironment];

    //注册图片加载器
    [WXSDKEngine registerHandler:[TCMWeexImageLoader new] withProtocol:@protocol(WXImgLoaderProtocol)];
    [WXSDKEngine registerHandler:[thybridNavigationDefaultImpl new] withProtocol:@protocol(WXNavigationProtocol)];

    //注册Model
    [tHybridModulesLoader loadModels:^(__unsafe_unretained Class modelClass, NSString *modelName) {
        [WXSDKEngine registerModule:modelName withClass:modelClass];
    }];
}

+ (void)initDeviceEnvironment{
    CGRect frame = [UIScreen mainScreen].bounds;
    NSInteger Width = CGRectGetWidth(frame);
    NSInteger Height = CGRectGetHeight(frame);
    if ((Width == 375 && Height != 667) || (Width == 414 && Height != 736)) {
        _Thybrid_Kit_Iphone_X_ = YES;
    }
}


+ (void)launchingWeex:(NSString *)networkEnvironment{
    //自定义网络环境变量
    [self setEnvironment:networkEnvironment];

    [self launchingWeex];
}

+ (void)setEnvironment:(NSString *)networkEnvironment{
    if (networkEnvironment) {
        [WXSDKEngine setCustomEnvironment:@{@"netEnv":networkEnvironment}];
    }
}

+ (void)resetEnvironment:(NSString *)networkEnvironment{
    if (networkEnvironment) {
        [self setEnvironment:networkEnvironment];
        [WXSDKEngine restart];
    }
}

+ (void)setCustomOption:(NSString *)key value:(NSString *)value{
    NSDictionary *opt = self.customOption;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (opt) {
        [dic addEntriesFromDictionary:opt];
    }
    [dic setValue:value forKey:key];
    [WXSDKEngine setCustomEnvironment:dic];
}

+ (NSDictionary *)customOption{
    return [WXSDKEngine customEnvironment];
}

+ (void)restart{
    [WXSDKEngine restart];
}

+ (BOOL)Thybrid_Kit_Iphone_X{
    return _Thybrid_Kit_Iphone_X_;
}

+ (NSInteger)Thybrid_Kit_Network_Working{
    return _Thybrid_Kit_Network_Working_;
}
+ (void)setThybrid_Kit_Network_Working:(NSInteger)Thybrid_Kit_Network_Working{
    _Thybrid_Kit_Network_Working_ = Thybrid_Kit_Network_Working;
    if (!Thybrid_Kit_Network_Working) {
        return;
    }
    UIWindow *win = [UIApplication sharedApplication].delegate.window;
    UIViewController *rootViewCoontroller = win.rootViewController;
    if ([rootViewCoontroller isKindOfClass:UINavigationController.class]) {
        UIViewController *topViewController = [(UINavigationController *)rootViewCoontroller topViewController];
        UIViewController *viewController = topViewController;
        if ([topViewController isKindOfClass:UITabBarController.class]) {
            viewController = [(UITabBarController *)topViewController selectedViewController];
        }

        [viewController rendererWeex];

    }

}
@end

//
//  TCMWeex.h
//  Weex
//
//  Created by Dao on 2018/1/9.
//  Copyright © 2018年 Taocaimall. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXTERN NSString *const tHybrid_remote_filepath_key;

/**
 *  启动Weex
 *    所需配置表：weexConfiguration.plist <module, class>
 */
@interface tHybridKit : NSObject

@property (class, nonatomic, assign) NSInteger Thybrid_Kit_Network_Working;
@property (class, nonatomic, assign, readonly) BOOL Thybrid_Kit_Iphone_X;

+ (void)launchingWeex;

+ (void)launchingWeex:(NSString *)env;

+ (void)resetEnvironment:(NSString *)networkEnvironment;

+ (void)setCustomOption:(NSString *)key  value:(NSString *)value;
+ (NSDictionary *)customOption;
+ (void)restart;

@end

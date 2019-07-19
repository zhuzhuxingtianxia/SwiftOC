//
//  NSString+MJExtension.h
//  MJExtensionExample
//
//  Created by MJ Lee on 15/6/7.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NTalkerExtensionConst.h"

@interface NSString (NTalkerExtension)
/**
 *  驼峰转下划线（loveYou -> love_you）
 */
- (NSString *)Ntalker_underlineFromCamel;
/**
 *  下划线转驼峰（love_you -> loveYou）
 */
- (NSString *)Ntalker_camelFromUnderline;
/**
 * 首字母变大写
 */
- (NSString *)Ntalker_firstCharUpper;
/**
 * 首字母变小写
 */
- (NSString *)Ntalker_firstCharLower;

- (BOOL)Ntalker_isPureInt;

- (NSURL *)Ntalker_url;
@end

@interface NSString (NTalkerExtensionDeprecated_v_2_5_16)
- (NSString *)Ntalker_underlineFromCamel NTalkerExtensionDeprecated("请在方法名前面加上Ntalker_前缀，使用Ntalker_***");
- (NSString *)Ntalker_camelFromUnderline NTalkerExtensionDeprecated("请在方法名前面加上Ntalker_前缀，使用Ntalker_***");
- (NSString *)Ntalker_firstCharUpper NTalkerExtensionDeprecated("请在方法名前面加上Ntalker_前缀，使用Ntalker_***");
- (NSString *)Ntalker_firstCharLower NTalkerExtensionDeprecated("请在方法名前面加上Ntalker_前缀，使用Ntalker_***");
- (BOOL)Ntalker_isPureInt NTalkerExtensionDeprecated("请在方法名前面加上Ntalker_前缀，使用Ntalker_***");
- (NSURL *)Ntalker_url NTalkerExtensionDeprecated("请在方法名前面加上Ntalker_前缀，使用Ntalker_***");
@end

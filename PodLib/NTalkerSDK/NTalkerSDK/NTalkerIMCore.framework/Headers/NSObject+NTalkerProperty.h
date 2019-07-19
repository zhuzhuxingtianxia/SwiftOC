//
//  NSObject+MJProperty.h
//  MJExtensionExample
//
//  Created by MJ Lee on 15/4/17.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NTalkerExtensionConst.h"

@class NTalkerProperty;

/**
 *  遍历成员变量用的block
 *
 *  @param property 成员的包装对象
 *  @param stop   YES代表停止遍历，NO代表继续遍历
 */
typedef void (^NTalkerPropertiesEnumeration)(NTalkerProperty *property, BOOL *stop);

/** 将属性名换为其他key去字典中取值 */
typedef NSDictionary * (^NTalkerReplacedKeyFromPropertyName)();
typedef id (^NTalkerReplacedKeyFromPropertyName121)(NSString *propertyName);
/** 数组中需要转换的模型类 */
typedef NSDictionary * (^NTalkerObjectClassInArray)();
/** 用于过滤字典中的值 */
typedef id (^NTalkerNewValueFromOldValue)(id object, id oldValue, NTalkerProperty *property);

/**
 * 成员属性相关的扩展
 */
@interface NSObject (NTalkerProperty)
#pragma mark - 遍历
/**
 *  遍历所有的成员
 */
+ (void)Ntalker_enumerateProperties:(NTalkerPropertiesEnumeration)enumeration;

#pragma mark - 新值配置
/**
 *  用于过滤字典中的值
 *
 *  @param newValueFormOldValue 用于过滤字典中的值
 */
+ (void)Ntalker_setupNewValueFromOldValue:(NTalkerNewValueFromOldValue)newValueFormOldValue;
+ (id)Ntalker_getNewValueFromObject:(__unsafe_unretained id)object oldValue:(__unsafe_unretained id)oldValue property:(__unsafe_unretained NTalkerProperty *)property;

#pragma mark - key配置
/**
 *  将属性名换为其他key去字典中取值
 *
 *  @param replacedKeyFromPropertyName 将属性名换为其他key去字典中取值
 */
+ (void)Ntalker_setupReplacedKeyFromPropertyName:(NTalkerReplacedKeyFromPropertyName)replacedKeyFromPropertyName;
/**
 *  将属性名换为其他key去字典中取值
 *
 *  @param replacedKeyFromPropertyName121 将属性名换为其他key去字典中取值
 */
+ (void)Ntalker_setupReplacedKeyFromPropertyName121:(NTalkerReplacedKeyFromPropertyName121)replacedKeyFromPropertyName121;

#pragma mark - array model class配置
/**
 *  数组中需要转换的模型类
 *
 *  @param objectClassInArray          数组中需要转换的模型类
 */
+ (void)Ntalker_setupObjectClassInArray:(NTalkerObjectClassInArray)objectClassInArray;
@end

@interface NSObject (NTalkerPropertyDeprecated_v_2_5_16)
+ (void)NTalker_enumerateProperties:(NTalkerPropertiesEnumeration)enumeration NTalkerExtensionDeprecated("请在方法名前面加上Ntalker_前缀，使用Ntalker_***");
+ (void)NTalker_setupNewValueFromOldValue:(NTalkerNewValueFromOldValue)newValueFormOldValue NTalkerExtensionDeprecated("请在方法名前面加上Ntalker_前缀，使用Ntalker_***");
+ (id)NTalker_getNewValueFromObject:(__unsafe_unretained id)object oldValue:(__unsafe_unretained id)oldValue property:(__unsafe_unretained NTalkerProperty *)property NTalkerExtensionDeprecated("请在方法名前面加上Ntalker_前缀，使用Ntalker_***");
+ (void)NTalker_setupReplacedKeyFromPropertyName:(NTalkerReplacedKeyFromPropertyName)replacedKeyFromPropertyName NTalkerExtensionDeprecated("请在方法名前面加上Ntalker_前缀，使用Ntalker_***");
+ (void)NTalker_setupReplacedKeyFromPropertyName121:(NTalkerReplacedKeyFromPropertyName121)replacedKeyFromPropertyName121 NTalkerExtensionDeprecated("请在方法名前面加上Ntalker_前缀，使用Ntalker_***");
+ (void)NTalker_setupObjectClassInArray:(NTalkerObjectClassInArray)objectClassInArray NTalkerExtensionDeprecated("请在方法名前面加上Ntalker_前缀，使用Ntalker_***");
@end


#import <Foundation/Foundation.h>

/**
 *  遍历所有类的block（父类）
 */
typedef void (^NTalkerClassesEnumeration)(Class c, BOOL *stop);

/** 这个数组中的属性名才会进行字典和模型的转换 */
typedef NSArray * (^NTalkerAllowedPropertyNames)();
/** 这个数组中的属性名才会进行归档 */
typedef NSArray * (^NTalkerAllowedCodingPropertyNames)();

/** 这个数组中的属性名将会被忽略：不进行字典和模型的转换 */
typedef NSArray * (^NTalkerIgnoredPropertyNames)();
/** 这个数组中的属性名将会被忽略：不进行归档 */
typedef NSArray * (^NTalkerIgnoredCodingPropertyNames)();

/**
 * 类相关的扩展
 */
@interface NSObject (NTalkerClass)
/**
 *  遍历所有的类
 */
+ (void)Ntalker_enumerateClasses:(NTalkerClassesEnumeration)enumeration;
+ (void)Ntalker_enumerateAllClasses:(NTalkerClassesEnumeration)enumeration;

#pragma mark - 属性白名单配置
/**
 *  这个数组中的属性名才会进行字典和模型的转换
 *
 *  @param allowedPropertyNames          这个数组中的属性名才会进行字典和模型的转换
 */
+ (void)Ntalker_setupAllowedPropertyNames:(NTalkerAllowedPropertyNames)allowedPropertyNames;

/**
 *  这个数组中的属性名才会进行字典和模型的转换
 */
+ (NSMutableArray *)Ntalker_totalAllowedPropertyNames;

#pragma mark - 属性黑名单配置
/**
 *  这个数组中的属性名将会被忽略：不进行字典和模型的转换
 *
 *  @param ignoredPropertyNames          这个数组中的属性名将会被忽略：不进行字典和模型的转换
 */
+ (void)Ntalker_setupIgnoredPropertyNames:(NTalkerIgnoredPropertyNames)ignoredPropertyNames;

/**
 *  这个数组中的属性名将会被忽略：不进行字典和模型的转换
 */
+ (NSMutableArray *)Ntalker_totalIgnoredPropertyNames;

#pragma mark - 归档属性白名单配置
/**
 *  这个数组中的属性名才会进行归档
 *
 *  @param allowedCodingPropertyNames          这个数组中的属性名才会进行归档
 */
+ (void)Ntalker_setupAllowedCodingPropertyNames:(NTalkerAllowedCodingPropertyNames)allowedCodingPropertyNames;

/**
 *  这个数组中的属性名才会进行字典和模型的转换
 */
+ (NSMutableArray *)Ntalker_totalAllowedCodingPropertyNames;

#pragma mark - 归档属性黑名单配置
/**
 *  这个数组中的属性名将会被忽略：不进行归档
 *
 *  @param ignoredCodingPropertyNames          这个数组中的属性名将会被忽略：不进行归档
 */
+ (void)Ntalker_setupIgnoredCodingPropertyNames:(NTalkerIgnoredCodingPropertyNames)ignoredCodingPropertyNames;

/**
 *  这个数组中的属性名将会被忽略：不进行归档
 */
+ (NSMutableArray *)Ntalker_totalIgnoredCodingPropertyNames;

#pragma mark - 内部使用
+ (void)Ntalker_setupBlockReturnValue:(id (^)())block key:(const char *)key;
@end

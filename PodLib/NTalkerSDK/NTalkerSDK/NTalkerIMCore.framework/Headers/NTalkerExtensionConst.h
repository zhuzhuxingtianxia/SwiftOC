
#ifndef __NTalkerExtensionConst__H__
#define __NTalkerExtensionConst__H__

#import <Foundation/Foundation.h>

// 过期
#define NTalkerExtensionDeprecated(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)

// 构建错误
#define NTalkerExtensionBuildError(clazz, msg) \
NSError *error = [NSError errorWithDomain:msg code:250 userInfo:nil]; \
[clazz setNtalker_error:error];

// 日志输出
#ifdef DEBUG
#define NTalkerExtensionLog(...) NSLog(__VA_ARGS__)
#else
#define NTalkerExtensionLog(...)
#endif

/**
 * 断言
 * @param condition   条件
 * @param returnValue 返回值
 */
#define NTalkerExtensionAssertError(condition, returnValue, clazz, msg) \
[clazz setNtalker_error:nil]; \
if ((condition) == NO) { \
    NTalkerExtensionBuildError(clazz, msg); \
    return returnValue;\
}

#define NTalkerExtensionAssert2(condition, returnValue) \
if ((condition) == NO) return returnValue;

/**
 * 断言
 * @param condition   条件
 */
#define NTalkerExtensionAssert(condition) NTalkerExtensionAssert2(condition, )

/**
 * 断言
 * @param param         参数
 * @param returnValue   返回值
 */
#define NTalkerExtensionAssertParamNotNil2(param, returnValue) \
NTalkerExtensionAssert2((param) != nil, returnValue)

/**
 * 断言
 * @param param   参数
 */
#define NTalkerExtensionAssertParamNotNil(param) NTalkerExtensionAssertParamNotNil2(param, )

/**
 * 打印所有的属性
 */
#define NTalkerLogAllIvars \
-(NSString *)description \
{ \
    return [self Ntalker_keyValues].description; \
}
#define NTalkerExtensionLogAllProperties NTalkerLogAllIvars

/**
 *  类型（属性类型）
 */
extern NSString *const NTalkerPropertyTypeInt;
extern NSString *const NTalkerPropertyTypeShort;
extern NSString *const NTalkerPropertyTypeFloat;
extern NSString *const NTalkerPropertyTypeDouble;
extern NSString *const NTalkerPropertyTypeLong;
extern NSString *const NTalkerPropertyTypeLongLong;
extern NSString *const NTalkerPropertyTypeChar;
extern NSString *const NTalkerPropertyTypeBOOL1;
extern NSString *const NTalkerPropertyTypeBOOL2;
extern NSString *const NTalkerPropertyTypePointer;

extern NSString *const NTalkerPropertyTypeIvar;
extern NSString *const NTalkerPropertyTypeMethod;
extern NSString *const NTalkerPropertyTypeBlock;
extern NSString *const NTalkerPropertyTypeClass;
extern NSString *const NTalkerPropertyTypeSEL;
extern NSString *const NTalkerPropertyTypeId;

#endif

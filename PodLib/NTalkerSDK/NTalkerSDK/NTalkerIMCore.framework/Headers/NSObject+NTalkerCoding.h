//
//  NSObject+MJCoding.h
//  MJExtension
//
//  Created by mj on 14-1-15.
//  Copyright (c) 2014年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NTalkerExtensionConst.h"

/**
 *  Codeing协议
 */
@protocol NTalkerCoding <NSObject>
@optional
/**
 *  这个数组中的属性名才会进行归档
 */
+ (NSArray *)Ntalker_allowedCodingPropertyNames;
/**
 *  这个数组中的属性名将会被忽略：不进行归档
 */
+ (NSArray *)Ntalker_ignoredCodingPropertyNames;
@end

@interface NSObject (NTalkerCoding) <NTalkerCoding>
/**
 *  解码（从文件中解析对象）
 */
- (void)Ntalker_decode:(NSCoder *)decoder;
/**
 *  编码（将对象写入文件中）
 */
- (void)Ntalker_encode:(NSCoder *)encoder;
@end

/**
 归档的实现
 */
#define NTalkerCodingImplementation \
- (id)initWithCoder:(NSCoder *)decoder \
{ \
if (self = [super init]) { \
[self Ntalker_decode:decoder]; \
} \
return self; \
} \
\
- (void)encodeWithCoder:(NSCoder *)encoder \
{ \
[self Ntalker_encode:encoder]; \
}

#define NTalkerExtensionCodingImplementation NTalkerCodingImplementation

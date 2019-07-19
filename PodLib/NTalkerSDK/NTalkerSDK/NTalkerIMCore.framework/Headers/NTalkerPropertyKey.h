//
//  MJPropertyKey.h
//  MJExtensionExample
//
//  Created by MJ Lee on 15/8/11.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    NTalkerPropertyKeyTypeDictionary = 0, // 字典的key
    NTalkerPropertyKeyTypeArray // 数组的key
} NTalkerPropertyKeyType;

/**
 *  属性的key
 */
@interface NTalkerPropertyKey : NSObject
/** key的名字 */
@property (copy,   nonatomic) NSString *name;
/** key的种类，可能是@"10"，可能是@"age" */
@property (assign, nonatomic) NTalkerPropertyKeyType type;

/**
 *  根据当前的key，也就是name，从object（字典或者数组）中取值
 */
- (id)Ntalker_valueInObject:(id)object;

@end

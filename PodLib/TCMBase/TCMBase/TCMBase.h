//
//  TCMBase.h
//
//  Created TCMBase
//  Copyright (c) on 2019/7/10..
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
// 用于添加一些工具类、文件管理类、中间桥接类、分类的扩展类

#import <Foundation/Foundation.h>

#if __has_include(<TCMBase/TCMBase.h>)

FOUNDATION_EXPORT double TCMBaseVersionNumber;
FOUNDATION_EXPORT const unsigned char TCMBaseVersionString[];
/*
 视图分类不可引入到TCMBase.h中，根据需要自己引入防止影响其他功能
 */

#import <TCMBase/TCMCheck.h>
#import <TCMBase/TCMFileManager.h>
#import <TCMBase/TCMRoute.h>

#import <TCMBase/NSObject+Bundle.h>
#import <TCMBase/NSString+AES.h>

#else

#import "TCMCheck.h"
#import "TCMFileManager.h"
#import "TCMRoute.h"

#import "NSObject+Bundle.h"
#import "NSString+AES.h"

#endif

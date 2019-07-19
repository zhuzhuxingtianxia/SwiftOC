//
//  NtalkerCoreConstant.h
//  NTalkerIMCore
//
//  Created by wzh on 2018/6/14.
//  Copyright © 2018年 NTalker. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NtalkerConfigureInfo.h"


typedef NS_ENUM(NSUInteger, Ntalker_ClientType){
    ClientType_CustomerService = 1,
    ClientType_Guest = 2,
    ClientType_Robot = 3,//不做集成使用
};

#ifndef NtalkerCoreConstant_h
#define NtalkerCoreConstant_h

//字符串保护
#define NtalkerProStr(str) ((str)?:@"")

//debug模式下的统计开关
//#define NtalkerDEBUGSTATISTICS

//日志开关
//#define NtalkerINTEGRATEDDEBUG

//#ifdef NtalkerINTEGRATEDDEBUG

//#define Ntalker_Log(fmt, ...) ![NtalkerConfigureInfo sharedInfo].enableLog?:NSLog((@"===[lineNum:%d],===[function:%s]" fmt), __LINE__, __FUNCTION__,##__VA_ARGS__);  //带行数
//#else
//#define Ntalker_Log(fmt, ...);
//#endif

//通知中心快捷初始化宏
#define NtalkerNotificitionCenter [NSNotificationCenter defaultCenter]

#endif /* NtalkerCoreConstant_h */



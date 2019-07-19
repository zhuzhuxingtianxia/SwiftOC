//
//  NtalkerCoreLog.h
//  NTalkerIMCore
//
//  Created by wzh on 2019/1/28.
//  Copyright © 2019 NTalker. All rights reserved.
//

#ifndef NtalkerCoreLog_h
#define NtalkerCoreLog_h
#import "NtalkerLogLib.h"
#import "NtalkerConfigureInfo.h"

//NtalkerLogDebug NtalkerLogInfo

#define NtalkerDebugLog(format, ...)\
@synchronized ([NtalkerConfigureInfo sharedInfo]) {\
    if([NtalkerConfigureInfo sharedInfo].enableLog){\
    NSLog((@"[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d]\n" format), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);\
    }\
}\

#define NtalkerInfoLog(format, ...)\
@synchronized ([NtalkerConfigureInfo sharedInfo]) {\
    if([NtalkerConfigureInfo sharedInfo].enableLog){\
    NSLog((@"[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d]\n" format), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);\
    }\
}\

#endif /* NtalkerCoreLog_h */

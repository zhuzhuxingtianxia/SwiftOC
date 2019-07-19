//
//  NtalkerLogLib.h
//  NtalkerToolsLib
//
//  Created by Lee on 2018/8/28.
//  Copyright © 2018年 NTalker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NtalkerCocoaLumberjack.h"

#ifdef DEBUG

#define NtalkerErrorLog(format, ...)   NtalkerLogError((@"[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d]\n" format), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);
#define NtalkerWarnLog(format, ...)    NtalkerLogWarn((@"[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d]\n" format), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);
//#define NtalkerInfoLog(format, ...)    NtalkerLogInfo((@"[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d]\n" format), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__)
//#define NtalkerDebugLog(format, ...)   NtalkerLogDebug((@"[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d]\n" format), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__)
#define NtalkerVerboseLog(format, ...) NtalkerLogVerbose((@"[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d]\n" format), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__)

#define Ntalker_Log(fmt, ...) NSLog((@"===[lineNum:%d],===[function:%s]" fmt), __LINE__, __FUNCTION__,##__VA_ARGS__);  //带行数


#else

#define NtalkerErrorLog(...);
#define NtalkerWarnLog(...);
#define NtalkerInfoLog(...);
#define NtalkerDebugLog(...);
#define NtalkerVerboseLog(...);
#define Ntalker_Log(...);

#endif

@interface NtalkerLogLib : NSObject

void ntalkerUncaughtExceptionHandler(NSException *exception);

//1.如果你将日志级别设置为 LOG_LEVEL_ERROR，那么你只会看到NtalkerlogError语句。
//2.如果你将日志级别设置为 LOG_LEVEL_WARN，那么你只会看到NtalkerLogError和NtalkerLogWarn语句。
//3.如果您将日志级别设置为 LOG_LEVEL_INFO,那么你会看到error、Warn和Info语句。
//4.如果您将日志级别设置为 LOG_LEVEL_VERBOSE,那么你会看到所有NtalkerLog语句。
//5.如果您将日志级别设置为 LOG_LEVEL_OFF,你将不会看到任何NtalkerLog语句。
+ (void)ntalkerLogToXcode:(BOOL)isLogToXcode logLevel:(NtalkerLogLevel)logLevel isOpenColor:(BOOL)isOpenColor isLogToFile:(BOOL)isLogToFile;

@end

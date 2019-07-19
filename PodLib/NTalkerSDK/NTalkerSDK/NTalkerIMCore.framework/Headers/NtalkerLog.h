// Software License Agreement (BSD License)
//
// Copyright (c) 2010-2015, Deusty, LLC
// All rights reserved.
//
// Redistribution and use of this software in source and binary forms,
// with or without modification, are permitted provided that the following conditions are met:
//
// * Redistributions of source code must retain the above copyright notice,
//   this list of conditions and the following disclaimer.
//
// * Neither the name of Deusty nor the names of its contributors may be used
//   to endorse or promote products derived from this software without specific
//   prior written permission of Deusty, LLC.

#import <Foundation/Foundation.h>

// Enable 1.9.x legacy macros if imported directly
#ifndef Ntalker_LEGACY_MACROS
    #define Ntalker_LEGACY_MACROS 1
#endif
#if Ntalker_LEGACY_MACROS
    #import "NtalkerLegacyMacros.h"
#endif

#if OS_OBJECT_USE_OBJC
    #define DISPATCH_QUEUE_REFERENCE_TYPE strong
#else
    #define DISPATCH_QUEUE_REFERENCE_TYPE assign
#endif

@class NtalkerLogMessage;
@protocol NtalkerLogger;
@protocol NtalkerLogFormatter;

/**
 * Define the standard options.
 *
 * We default to only 4 levels because it makes it easier for beginners
 * to make the transition to a logging framework.
 *
 * More advanced users may choose to completely customize the levels (and level names) to suite their needs.
 * For more information on this see the "Custom Log Levels" page:
 * Documentation/CustomLogLevels.md
 *
 * Advanced users may also notice that we're using a bitmask.
 * This is to allow for custom fine grained logging:
 * Documentation/FineGrainedLogging.md
 *
 * -- Flags --
 *
 * Typically you will use the LOG_LEVELS (see below), but the flags may be used directly in certain situations.
 * For example, say you have a lot of warning log messages, and you wanted to disable them.
 * However, you still needed to see your error and info log messages.
 * You could accomplish that with the following:
 *
 * static const NtalkerLogLevel NtalkerLogLevel = NtalkerLogFlagError | NtalkerLogFlagInfo;
 *
 * When LOG_LEVEL_DEF is defined as NtalkerLogLevel.
 *
 * Flags may also be consulted when writing custom log formatters,
 * as the NtalkerLogMessage class captures the individual flag that caused the log message to fire.
 *
 * -- Levels --
 *
 * Log levels are simply the proper bitmask of the flags.
 *
 * -- Booleans --
 *
 * The booleans may be used when your logging code involves more than one line.
 * For example:
 *
 * if (LOG_VERBOSE) {
 *     for (id sprocket in sprockets)
 *         NtalkerLogVerbose(@"sprocket: %@", [sprocket description])
 * }
 *
 * -- Async --
 *
 * Defines the default asynchronous options.
 * The default philosophy for asynchronous logging is very simple:
 *
 * Log messages with errors should be executed synchronously.
 *     After all, an error just occurred. The application could be unstable.
 *
 * All other log messages, such as debug output, are executed asynchronously.
 *     After all, if it wasn't an error, then it was just informational output,
 *     or something the application was easily able to recover from.
 *
 * -- Changes --
 *
 * You are strongly discouraged from modifying this file.
 * If you do, you make it more difficult on yourself to merge future bug fixes and improvements from the project.
 * Instead, create your own MyLogging.h or ApplicationNameLogging.h or CompanyLogging.h
 *
 * For an example of customizing your logging experience, see the "Custom Log Levels" page:
 * Documentation/CustomLogLevels.md
 **/

typedef NS_OPTIONS(NSUInteger, NtalkerLogFlag) {
    NtalkerLogFlagError      = (1 << 0), // 0...00001
    NtalkerLogFlagWarning    = (1 << 1), // 0...00010
    NtalkerLogFlagInfo       = (1 << 2), // 0...00100
    NtalkerLogFlagDebug      = (1 << 3), // 0...01000
    NtalkerLogFlagVerbose    = (1 << 4)  // 0...10000
};

typedef NS_ENUM(NSUInteger, NtalkerLogLevel) {
    NtalkerLogLevelOff       = 0,
    NtalkerLogLevelError     = (NtalkerLogFlagError),                       // 0...00001
    NtalkerLogLevelWarning   = (NtalkerLogLevelError   | NtalkerLogFlagWarning), // 0...00011
    NtalkerLogLevelInfo      = (NtalkerLogLevelWarning | NtalkerLogFlagInfo),    // 0...00111
    NtalkerLogLevelDebug     = (NtalkerLogLevelInfo    | NtalkerLogFlagDebug),   // 0...01111
    NtalkerLogLevelVerbose   = (NtalkerLogLevelDebug   | NtalkerLogFlagVerbose), // 0...11111
    NtalkerLogLevelAll       = NSUIntegerMax                           // 1111....11111 (NtalkerLogLevelVerbose plus any other flags)
};

/**
 * The THIS_FILE macro gives you an NSString of the file name.
 * For simplicity and clarity, the file name does not include the full path or file extension.
 *
 * For example: NtalkerLogWarn(@"%@: Unable to find thingy", THIS_FILE) -> @"MyViewController: Unable to find thingy"
 **/

NSString * NtalkerExtractFileNameWithoutExtension(const char *filePath, BOOL copy);

#define THIS_FILE         (NtalkerExtractFileNameWithoutExtension(__FILE__, NO))

/**
 * The THIS_METHOD macro gives you the name of the current objective-c method.
 *
 * For example: NtalkerLogWarn(@"%@ - Requires non-nil strings", THIS_METHOD) -> @"setMake:model: requires non-nil strings"
 *
 * Note: This does NOT work in straight C functions (non objective-c).
 * Instead you should use the predefined __FUNCTION__ macro.
 **/

#define THIS_METHOD       NSStringFromSelector(_cmd)


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

@interface NtalkerLog : NSObject

/**
 * Provides access to the underlying logging queue.
 * This may be helpful to Logger classes for things like thread synchronization.
 **/

+ (dispatch_queue_t)loggingQueue;

/**
 * Logging Primitive.
 *
 * This method is used by the macros above.
 * It is suggested you stick with the macros as they're easier to use.
 **/

+ (void)log:(BOOL)synchronous
      level:(NtalkerLogLevel)level
       flag:(NtalkerLogFlag)flag
    context:(NSInteger)context
       file:(const char *)file
   function:(const char *)function
       line:(NSUInteger)line
        tag:(id)tag
     format:(NSString *)format, ... NS_FORMAT_FUNCTION(9,10);

/**
 * Logging Primitive.
 *
 * This method can be used if you have a prepared va_list.
 **/

+ (void)log:(BOOL)asynchronous
      level:(NtalkerLogLevel)level
       flag:(NtalkerLogFlag)flag
    context:(NSInteger)context
       file:(const char *)file
   function:(const char *)function
       line:(NSUInteger)line
        tag:(id)tag
     format:(NSString *)format
       args:(va_list)argList;

/**
 * Logging Primitive.
 **/
+ (void)log:(BOOL)asynchronous
    message:(NSString *)message
      level:(NtalkerLogLevel)level
       flag:(NtalkerLogFlag)flag
    context:(NSInteger)context
       file:(const char *)file
   function:(const char *)function
       line:(NSUInteger)line
        tag:(id)tag;

/**
 * Logging Primitive.
 *
 * This method can be used if you manualy prepared NtalkerLogMessage.
 **/

+ (void)log:(BOOL)asynchronous
    message:(NtalkerLogMessage *)logMessage;

/**
 * Since logging can be asynchronous, there may be times when you want to flush the logs.
 * The framework invokes this automatically when the application quits.
 **/

+ (void)flushLog;

/**
 * Loggers
 *
 * In order for your log statements to go somewhere, you should create and aNtalker a logger.
 *
 * You can aNtalker multiple loggers in order to direct your log statements to multiple places.
 * And each logger can be configured separately.
 * So you could have, for example, verbose logging to the console, but a concise log file with only warnings & errors.
 **/

/**
 * ANtalkers the logger to the system.
 *
 * This is equivalent to invoking [NtalkerLog aNtalkerLogger:logger withLogLevel:NtalkerLogLevelAll].
 **/
+ (void)aNtalkerLogger:(id <NtalkerLogger>)logger;

/**
 * ANtalkers the logger to the system.
 *
 * The level that you provide here is a preemptive filter (for performance).
 * That is, the level specified here will be used to filter out logMessages so that
 * the logger is never even invoked for the messages.
 *
 * More information:
 * When you issue a log statement, the logging framework iterates over each logger,
 * and checks to see if it should forward the logMessage to the logger.
 * This check is done using the level parameter passed to this method.
 *
 * For example:
 *
 * [NtalkerLog aNtalkerLogger:consoleLogger withLogLevel:NtalkerLogLevelVerbose];
 * [NtalkerLog aNtalkerLogger:fileLogger    withLogLevel:NtalkerLogLevelWarning];
 *
 * NtalkerLogError(@"oh no"); => gets forwarded to consoleLogger & fileLogger
 * NtalkerLogInfo(@"hi");     => gets forwarded to consoleLogger only
 *
 * It is important to remember that Lumberjack uses a BITMASK.
 * Many developers & third party frameworks may define extra log levels & flags.
 * For example:
 *
 * #define SOME_FRAMEWORK_LOG_FLAG_TRACE (1 << 6) // 0...1000000
 *
 * So if you specify NtalkerLogLevelVerbose to this method, you won't see the framework's trace messages.
 *
 * (SOME_FRAMEWORK_LOG_FLAG_TRACE & NtalkerLogLevelVerbose) => (01000000 & 00011111) => NO
 *
 * Consider passing NtalkerLogLevelAll to this method, which has all bits set.
 * You can also use the exclusive-or bitwise operator to get a bitmask that has all flags set,
 * except the ones you explicitly don't want. For example, if you wanted everything except verbose & debug:
 *
 * ((NtalkerLogLevelAll ^ NtalkerLogLevelVerbose) | NtalkerLogLevelInfo)
 **/
+ (void)aNtalkerLogger:(id <NtalkerLogger>)logger withLevel:(NtalkerLogLevel)level;

+ (void)removeLogger:(id <NtalkerLogger>)logger;
+ (void)removeAllLoggers;

+ (NSArray *)allLoggers;

/**
 * Registered Dynamic Logging
 *
 * These methods allow you to obtain a list of classes that are using registered dynamic logging,
 * and also provides methods to get and set their log level during run time.
 **/

+ (NSArray *)registeredClasses;
+ (NSArray *)registeredClassNames;

+ (NtalkerLogLevel)levelForClass:(Class)aClass;
+ (NtalkerLogLevel)levelForClassWithName:(NSString *)aClassName;

+ (void)setLevel:(NtalkerLogLevel)level forClass:(Class)aClass;
+ (void)setLevel:(NtalkerLogLevel)level forClassWithName:(NSString *)aClassName;

@end

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

@protocol NtalkerLogger <NSObject>

- (void)logMessage:(NtalkerLogMessage *)logMessage;

/**
 * Formatters may optionally be aNtalkered to any logger.
 *
 * If no formatter is set, the logger simply logs the message as it is given in logMessage,
 * or it may use its own built in formatting style.
 **/
@property (nonatomic, strong) id <NtalkerLogFormatter> logFormatter;

@optional

/**
 * Since logging is asynchronous, aNtalkering and removing loggers is also asynchronous.
 * In other words, the loggers are aNtalkered and removed at appropriate times with regards to log messages.
 *
 * - Loggers will not receive log messages that were executed prior to when they were aNtalkered.
 * - Loggers will not receive log messages that were executed after they were removed.
 *
 * These methods are executed in the logging thread/queue.
 * This is the same thread/queue that will execute every logMessage: invocation.
 * Loggers may use these methods for thread synchronization or other setup/teardown tasks.
 **/
- (void)didANtalkerLogger;
- (void)willRemoveLogger;

/**
 * Some loggers may buffer IO for optimization purposes.
 * For example, a database logger may only save occasionaly as the disk IO is slow.
 * In such loggers, this method should be implemented to flush any pending IO.
 *
 * This allows invocations of NtalkerLog's flushLog method to be propogated to loggers that need it.
 *
 * Note that NtalkerLog's flushLog method is invoked automatically when the application quits,
 * and it may be also invoked manually by the developer prior to application crashes, or other such reasons.
 **/
- (void)flush;

/**
 * Each logger is executed concurrently with respect to the other loggers.
 * Thus, a dedicated dispatch queue is used for each logger.
 * Logger implementations may optionally choose to provide their own dispatch queue.
 **/
@property (nonatomic, DISPATCH_QUEUE_REFERENCE_TYPE, readonly) dispatch_queue_t loggerQueue;

/**
 * If the logger implementation does not choose to provide its own queue,
 * one will automatically be created for it.
 * The created queue will receive its name from this method.
 * This may be helpful for debugging or profiling reasons.
 **/
@property (nonatomic, readonly) NSString *loggerName;

@end

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

@protocol NtalkerLogFormatter <NSObject>
@required

/**
 * Formatters may optionally be aNtalkered to any logger.
 * This allows for increased flexibility in the logging environment.
 * For example, log messages for log files may be formatted differently than log messages for the console.
 *
 * For more information about formatters, see the "Custom Formatters" page:
 * Documentation/CustomFormatters.md
 *
 * The formatter may also optionally filter the log message by returning nil,
 * in which case the logger will not log the message.
 **/
- (NSString *)formatLogMessage:(NtalkerLogMessage *)logMessage;

@optional

/**
 * A single formatter instance can be aNtalkered to multiple loggers.
 * These methods provides hooks to notify the formatter of when it's aNtalkered/removed.
 *
 * This is primarily for thread-safety.
 * If a formatter is explicitly not thread-safe, it may wish to throw an exception if aNtalkered to multiple loggers.
 * Or if a formatter has potentially thread-unsafe code (e.g. NSDateFormatter),
 * it could possibly use these hooks to switch to thread-safe versions of the code.
 **/
- (void)didANtalkerToLogger:(id <NtalkerLogger>)logger;
- (void)willRemoveFromLogger:(id <NtalkerLogger>)logger;

@end

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

@protocol NtalkerRegistereNtalkerynamicLogging

/**
 * Implement these methods to allow a file's log level to be managed from a central location.
 *
 * This is useful if you'd like to be able to change log levels for various parts
 * of your code from within the running application.
 *
 * Imagine pulling up the settings for your application,
 * and being able to configure the logging level on a per file basis.
 *
 * The implementation can be very straight-forward:
 *
 * + (int)NtalkerLogLevel
 * {
 *     return NtalkerLogLevel;
 * }
 *
 * + (void)NtalkerSetLogLevel:(NtalkerLogLevel)level
 * {
 *     NtalkerLogLevel = level;
 * }
 **/

+ (NtalkerLogLevel)NtalkerLogLevel;
+ (void)NtalkerSetLogLevel:(NtalkerLogLevel)level;

@end

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#ifndef NS_DESIGNATED_INITIALIZER
    #define NS_DESIGNATED_INITIALIZER
#endif

/**
 * The NtalkerLogMessage class encapsulates information about the log message.
 * If you write custom loggers or formatters, you will be dealing with objects of this class.
 **/

typedef NS_OPTIONS(NSInteger, NtalkerLogMessageOptions) {
    NtalkerLogMessageCopyFile     = 1 << 0,
    NtalkerLogMessageCopyFunction = 1 << 1
};

@interface NtalkerLogMessage : NSObject <NSCopying>
{
    // Direct accessors to be used only for performance
    @public
    NSString *_message;
    NtalkerLogLevel _level;
    NtalkerLogFlag _flag;
    NSInteger _context;
    NSString *_file;
    NSString *_fileName;
    NSString *_function;
    NSUInteger _line;
    id _tag;
    NtalkerLogMessageOptions _options;
    NSDate *_timestamp;
    NSString *_threadID;
    NSString *_threadName;
    NSString *_queueLabel;
}

/**
 * Standard init method for a log message object.
 * Used by the logging primitives. (And the macros use the logging primitives.)
 *
 * If you find need to manually create logMessage objects, there is one thing you should be aware of:
 *
 * If no flags are passed, the method expects the file and function parameters to be string literals.
 * That is, it expects the given strings to exist for the duration of the object's lifetime,
 * and it expects the given strings to be immutable.
 * In other words, it does not copy these strings, it simply points to them.
 * This is due to the fact that __FILE__ and __FUNCTION__ are usually used to specify these parameters,
 * so it makes sense to optimize and skip the unnecessary allocations.
 * However, if you need them to be copied you may use the options parameter to specify this.
 * Options is a bitmask which supports NtalkerLogMessageCopyFile and NtalkerLogMessageCopyFunction.
 **/
- (instancetype)initWithMessage:(NSString *)message
                          level:(NtalkerLogLevel)level
                           flag:(NtalkerLogFlag)flag
                        context:(NSInteger)context
                           file:(NSString *)file
                       function:(NSString *)function
                           line:(NSUInteger)line
                            tag:(id)tag
                        options:(NtalkerLogMessageOptions)options
                      timestamp:(NSDate *)timestamp NS_DESIGNATED_INITIALIZER;

/**
 * Read-only properties
 **/
@property (readonly, nonatomic) NSString *message;
@property (readonly, nonatomic) NtalkerLogLevel level;
@property (readonly, nonatomic) NtalkerLogFlag flag;
@property (readonly, nonatomic) NSInteger context;
@property (readonly, nonatomic) NSString *file;
@property (readonly, nonatomic) NSString *fileName;
@property (readonly, nonatomic) NSString *function;
@property (readonly, nonatomic) NSUInteger line;
@property (readonly, nonatomic) id tag;
@property (readonly, nonatomic) NtalkerLogMessageOptions options;
@property (readonly, nonatomic) NSDate *timestamp;
@property (readonly, nonatomic) NSString *threadID; // ID as it appears in NSLog calculated from the machThreadID
@property (readonly, nonatomic) NSString *threadName;
@property (readonly, nonatomic) NSString *queueLabel;

@end

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * The NtalkerLogger protocol specifies that an optional formatter can be aNtalkered to a logger.
 * Most (but not all) loggers will want to support formatters.
 *
 * However, writting getters and setters in a thread safe manner,
 * while still maintaining maximum speed for the logging process, is a difficult task.
 *
 * To do it right, the implementation of the getter/setter has strict requiremenets:
 * - Must NOT require the logMessage method to acquire a lock.
 * - Must NOT require the logMessage method to access an atomic property (also a lock of sorts).
 *
 * To simplify things, an abstract logger is provided that implements the getter and setter.
 *
 * Logger implementations may simply extend this class,
 * and they can ACCESS THE FORMATTER VARIABLE DIRECTLY from within their logMessage method!
 **/

@interface NtalkerAbstractLogger : NSObject <NtalkerLogger>
{
    // Direct accessors to be used only for performance
    @public
    id <NtalkerLogFormatter> _logFormatter;
    dispatch_queue_t _loggerQueue;
}

@property (nonatomic, strong) id <NtalkerLogFormatter> logFormatter;
@property (nonatomic, DISPATCH_QUEUE_REFERENCE_TYPE) dispatch_queue_t loggerQueue;

// For thread-safety assertions
@property (nonatomic, readonly, getter=isOnGlobalLoggingQueue)  BOOL onGlobalLoggingQueue;
@property (nonatomic, readonly, getter=isOnInternalLoggerQueue) BOOL onInternalLoggerQueue;

@end


//
//  TCMFileManager.h
//  TCMDemo
//
//  Created by Aaron on 2016/11/8.
//  Copyright © 2016年 Taocaimall Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TCMFileManager : NSObject

+ (NSString *)getFileDomain;
+ (BOOL)isFileExistsAtPath:(NSString *)path;

+ (void) writeArray:(NSMutableArray *)arr toFile:(NSString*)fileName;
+ (NSMutableArray *) readArrayFromFile:(NSString * )fileName;

+ (void)writeDictionary:(NSDictionary *)dictionary toFile:(NSString *)fileName;
+ (NSDictionary *)readDictionaryFromFile:(NSString *)fileName;

+ (void)archiveRootObject:(id)object toFile:(NSString *)fileName;
+ (id)unArchiveObjectWithFile:(NSString *)fileName;

+ (void)writeData:(NSData *)data toFile:(NSString *)fileName;
+ (NSData *)readDataFromFile:(NSString *)fileName;

+ (void)writeString:(NSString *)str toFile:(NSString *)fileName;
+ (NSString *)readStringFromFile:(NSString *)fileName;

+ (NSString *)theDBPath;

@end

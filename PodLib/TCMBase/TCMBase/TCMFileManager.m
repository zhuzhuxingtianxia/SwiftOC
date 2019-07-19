//
//  TCMFileManager.m
//  TCMDemo
//
//  Created by Aaron on 2016/11/8.
//  Copyright © 2016年 Taocaimall Inc. All rights reserved.
//

#import "TCMFileManager.h"

@implementation TCMFileManager

+ (NSString*) getFileDomain{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString * directoryPath = [paths.firstObject stringByAppendingPathComponent:@"TCM_Caches"];
    
    if (![self isFileExistsAtPath:directoryPath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:0];
    }
    return directoryPath;
}

+ (BOOL) isFileExistsAtPath:(NSString *)path{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:path])
    {
        return NO;
    }
    return YES;
}

+ (void) writeArray:(NSMutableArray *)arr toFile:(NSString*)fileName{
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",[self getFileDomain], fileName];
    if (![self isFileExistsAtPath:filePath]){
        [[NSFileManager defaultManager] createFileAtPath:filePath contents:nil attributes:nil];
    }
    [arr writeToFile:filePath atomically:YES];
}

+ (NSMutableArray *) readArrayFromFile:(NSString *)fileName{
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",[self getFileDomain], fileName];
    if(![self isFileExistsAtPath:filePath])
        return nil;
    else
        return [NSMutableArray arrayWithContentsOfFile:filePath];
}

+ (void)writeDictionary:(NSDictionary *)dictionary toFile:(NSString *)fileName{
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",[self getFileDomain], fileName];
    if (![self isFileExistsAtPath:filePath]){
        [[NSFileManager defaultManager] createFileAtPath:filePath contents:nil attributes:nil];
    }
    [dictionary writeToFile:filePath atomically:YES];
}

+ (NSDictionary *)readDictionaryFromFile:(NSString *)fileName{
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",[self getFileDomain], fileName];
    if(![self isFileExistsAtPath:filePath])
        return nil;
    else
        return [NSDictionary dictionaryWithContentsOfFile:filePath];
}


+ (void)archiveRootObject:(id)object toFile:(NSString *)fileName{
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",[self getFileDomain], fileName];
    if (![self isFileExistsAtPath:filePath]){
        [[NSFileManager defaultManager] createFileAtPath:filePath contents:nil attributes:nil];
    }
    [NSKeyedArchiver archiveRootObject:object toFile:filePath];
}


+ (id)unArchiveObjectWithFile:(NSString *)fileName{
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",[self getFileDomain], fileName];
    if(![self isFileExistsAtPath:filePath])
        return nil;
    else
        return [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];//
}

+ (void)writeData:(NSData *)data toFile:(NSString *)fileName{
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",[self getFileDomain], fileName];
    if (![self isFileExistsAtPath:filePath]){
        [[NSFileManager defaultManager] createFileAtPath:filePath contents:nil attributes:nil];
    }
    [data writeToFile:filePath atomically:YES];
}

+ (NSData *)readDataFromFile:(NSString *)fileName{
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",[self getFileDomain], fileName];
    if(![self isFileExistsAtPath:filePath])
        return nil;
    else
        return [NSData dataWithContentsOfFile:filePath];
}

+ (void)writeString:(NSString *)str toFile:(NSString *)fileName{
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",[self getFileDomain], fileName];
    if (![self isFileExistsAtPath:filePath]){
        [[NSFileManager defaultManager] createFileAtPath:filePath contents:nil attributes:nil];
    }
    [str writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:0];
}

+ (NSString *)readStringFromFile:(NSString *)fileName{
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",[self getFileDomain], fileName];
    if(![self isFileExistsAtPath:filePath])
        return nil;
    else
        return [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:0];
}

+ (NSString *)theDBPath
{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString * directoryPath = [paths.firstObject stringByAppendingPathComponent:@"/DB"];
    
    if (![self isFileExistsAtPath:directoryPath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:0];
    }
    return directoryPath;
}

@end

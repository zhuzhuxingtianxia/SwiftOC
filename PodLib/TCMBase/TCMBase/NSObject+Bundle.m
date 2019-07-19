//
//  NSObject+Bundle.m
//  AFNetworking
//
//  Created by ZZJ on 2019/7/13.
//

#import "NSObject+Bundle.h"

@implementation NSObject (Bundle)
- (NSString *)bundleDisplayName{
    return  [NSObject bundleDisplayName];
}
+ (NSString *)bundleDisplayName{
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSDictionary *info = [bundle infoDictionary];
    
    NSString *bundleDisplayName = [info valueForKey:@"CFBundleDisplayName"];
    
    return bundleDisplayName;
}

- (NSString *)projectName{
    return  [NSObject projectName];
}
+ (NSString *)projectName{
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSDictionary *info = [bundle infoDictionary];
    
    NSString *bundleDisplayName = [info valueForKey:(__bridge NSString *)kCFBundleNameKey];
    
    return bundleDisplayName;
}

- (NSString *)bundleVersion{
    return [NSObject bundleVersion];
}

+ (NSString *)bundleVersion{
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersionStr = [infoDict objectForKey:@"CFBundleShortVersionString"];
    
    return currentVersionStr;
}

- (NSString *)bundleBuildVersion{
    return [NSObject bundleBuildVersion];
}
+ (NSString *)bundleBuildVersion{
    return [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleVersionKey];
}

- (NSString *)bundleIdentifier{
    return [NSObject bundleIdentifier];
}
+ (NSString *)bundleIdentifier{
    return [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleIdentifierKey];
}

@end

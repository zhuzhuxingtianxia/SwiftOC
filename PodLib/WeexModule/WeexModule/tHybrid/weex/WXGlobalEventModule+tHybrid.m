//
//  WXGlobalEventModule+tHybrid.m
//  AFNetworking
//
//  Created by Dao on 2018/12/3.
//

#import "WXGlobalEventModule+tHybrid.h"

@implementation WXGlobalEventModule (tHybrid)

WX_EXPORT_METHOD(@selector(postNotificationName:object:))
- (void)postNotificationName:(NSString *)name object:(nullable id)anObject{
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:anObject];
}


@end

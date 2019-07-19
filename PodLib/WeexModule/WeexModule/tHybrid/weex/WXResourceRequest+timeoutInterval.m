//
//  WXResourceRequest+thybrid.m
//  AFNetworking
//
//  Created by Dao on 2018/11/19.
//

#import "WXResourceRequest+timeoutInterval.h"
#import <objc/runtime.h>


@implementation WXResourceRequest (timeoutInterval)

+ (void)load{
    Method thybrid_setType = class_getInstanceMethod(self, @selector(thybrid_setType:));
    Method setType = class_getInstanceMethod(self, @selector(setType:));
    method_exchangeImplementations(setType, thybrid_setType);
}


- (void)thybrid_setType:(WXResourceType)type{
    [self thybrid_setType:type];

    switch (type) {
        case WXResourceTypeMainBundle:
            self.timeoutInterval = 10;
            break;
        case WXResourceTypeImage:
            break;
        default:
            break;
    }
}



@end

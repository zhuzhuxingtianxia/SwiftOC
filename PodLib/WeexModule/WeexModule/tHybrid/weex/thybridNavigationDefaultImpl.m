//
//  thybridNavigationDefaultImpl.m
//  AFNetworking
//
//  Created by Dao on 2018/10/25.
//

#import "thybridNavigationDefaultImpl.h"
#import "UIViewController+tHybridWeex.h"

#import "thybridNavigationOption.h"

@implementation thybridNavigationDefaultImpl

- (void)pushViewControllerWithParam:(NSDictionary *)param completion:(WXNavigationResultBlock)block
                      withContainer:(UIViewController *)container
{
    thybridNavigationOption *option = [thybridNavigationOption objectWithKeyValues:param];

    [container performSelectorOnMainThread:@selector(springWithOption:) withObject:option waitUntilDone:NO];

}

- (void)popViewControllerWithParam:(NSDictionary *)param completion:(WXNavigationResultBlock)block
                     withContainer:(UIViewController *)container
{
    thybridNavigationOption *option = [thybridNavigationOption objectWithKeyValues:param];

    [container performSelectorOnMainThread:@selector(pop:) withObject:option waitUntilDone:NO];
}



@end

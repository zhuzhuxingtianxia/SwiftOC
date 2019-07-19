//
//  TCMLoginManger.m
//  AFNetworking
//
//  Created by ZZJ on 2019/7/12.
//

#import "TCMLoginManger.h"
#import "TCMLoginController.h"

@interface TCMLoginManger ()

@end
@implementation TCMLoginManger

+(BOOL)isLogin {
    return NO;
}

+(BOOL)loginView:(UIViewController*)weakSelf {
    if (![self isLogin]) {
        
        TCMLoginController *loginVC = [[TCMLoginController alloc] init];
        
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
        if (@available(iOS 5.0, *)) {
            [weakSelf presentViewController:nav animated:YES completion:^{
                
            }];
        } else {
            // Fallback on earlier versions
        }
        return [self isLogin];
    }
    return YES;
}

@end

//
//  TCMLoginManger.h
//  AFNetworking
//
//  Created by ZZJ on 2019/7/12.
// 登陆退出采用通知的方式

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TCMLoginManger : NSObject

+(BOOL)loginView:(UIViewController*)weakSelf;

@end

NS_ASSUME_NONNULL_END

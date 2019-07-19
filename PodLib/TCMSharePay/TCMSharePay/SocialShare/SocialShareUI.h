//
//  SocialShareUI.h
//  Superior
//
//  Created by Dao on 2018/7/26.
//  Copyright © 2018 淘菜猫. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SocialShare.h"

typedef void(^SocialShareSelectionBlock)(SocialSharePlatform platform, NSDictionary *userInfo);

@protocol SocialShareUIDelegate<NSObject>

@required
- (void)selectPlatform:(SocialSharePlatform)platform userInfo:(NSDictionary *)userInfo;

@end


@interface SocialShareUI : NSObject

@property (class, nonatomic, strong) SocialShareMessage *message;

+ (void)showShareMenuInWindowWithPlatformArray:(NSArray<NSNumber *> *)platform
                                      delegate:(id<SocialShareUIDelegate>)delegate;
+ (void)showShareMenuInWindowWithPlatform:(SocialSharePlatform)platform
                                 delegate:(id<SocialShareUIDelegate>)delegate;

+ (void)showShareMenuInWindowWithPlatformArray:(NSArray<NSNumber *> *)platform
                           selectionBlock:(SocialShareSelectionBlock)selectionBlock;
+ (void)showShareMenuInWindowWithPlatform:(SocialSharePlatform)platform
                           selectionBlock:(SocialShareSelectionBlock)selectionBlock;


+ (void)registerPlatform:(SocialSharePlatform)platform
            platformName:(NSString *)name
                    icon:(UIImage *)icon;

@end

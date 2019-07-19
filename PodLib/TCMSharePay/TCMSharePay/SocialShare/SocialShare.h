//
//  SocialShare.h
//  Superior
//
//  Created by Dao on 2018/7/26.
//  Copyright © 2018 淘菜猫. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WechatOpenSDK/WXApi.h>
#import "SocialShareMessage.h"
#import <WeexSDK/WeexSDK.h>
@interface WEEXSocialShare : NSObject<WXModuleProtocol>


/**
 分享信息

 @param platform 分享平台：0.微信朋友圈 1.微信好友 2.QQ好友 3.QQ空间
 @param title 主标题
 @param subTitle 副标题
 @param thumbnail 缩略图URL
 @param shareLink 待分享链接
 */
- (void)sendMessage:(NSString *)platform
              title:(NSString *)title
           subTitle:(NSString *)subTitle
          thumbnail:(NSString *)thumbnail
          shareLink:(NSString *)shareLink;


@end


@interface SocialShare : NSObject


/**
 *  独立设置时请放置到Message设置之后
 */

+ (void)sendMessage:(SocialShareMessage *)message;
+ (void)sendMessage:(SocialShareMessage *)message delegate:(id<SocialShareRespondDelegate>)delegate;
+ (void)sendMessage:(SocialShareMessage *)message respondBlock:(SocialShareRespondBlock)respondBlock;

+ (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options;

+ (void)cancel;
@end



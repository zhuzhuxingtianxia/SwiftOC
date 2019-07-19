//
//  SocialShareMessage.h
//  Superior
//
//  Created by Dao on 2018/7/26.
//  Copyright © 2018 淘菜猫. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSUInteger, SocialSharePlatform) {
    SocialShareMessage_Unknow = 0,
    SocialSharePlatform_WeChat_Timeline = 1 << 0,
    SocialSharePlatform_WeChat_Session = 1 << 1,
    SocialSharePlatform_QQ_Session = 1 << 2,
    SocialSharePlatform_QQ_Zone = 1 << 3,
};

typedef NS_ENUM(NSUInteger, SocialShareType) {
    SocialShareTypeText = 1,
    SocialShareTypeImage,
    SocialShareTypeWeb,
    SocialShareTypeVideo,
    SocialShareTypeMusic,
    SocialShareTypeApp,
    SocialShareTypePay,
    SocialShareTypeAuth,
};

typedef NS_ENUM(NSInteger, SocialShareResultCode) {
    SocialShareResultCodeSuccess           = 0,    /**< 成功    */
    SocialShareResultCodeCommon     = -1,   /**< 普通错误类型    */
    SocialShareResultCodeUserCancel = -2,   /**< 用户点击取消并返回    */
    SocialShareResultCodeSentFail   = -3,   /**< 发送失败    */
    SocialShareResultCodeAuthDeny   = -4,   /**< 授权失败    */
    SocialShareResultCodeUnsupport  = -5,   /**< 不支持    */

};

@class SocialShareResp;

typedef void(^SocialShareRespondBlock)(SocialShareResp *resp);

@protocol SocialShareRespondDelegate<NSObject>

@required
- (void)socialShareRespond:(SocialShareResp *)resp;

@end

@interface SocialShareMessage : NSObject<NSCopying>

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) UIImage *thumbImage;
@property (nonatomic, copy) NSString *url;

@property (nonatomic, assign) SocialSharePlatform platform;
@property (nonatomic, assign) SocialShareType shareType;

@property (nonatomic, copy) id option;
@property (nonatomic, strong) id message;
@property (nonatomic, weak) id<SocialShareRespondDelegate> delegate;
@property (nonatomic, copy) SocialShareRespondBlock  respondBlock;

@property (nonatomic, assign, readonly, getter=canRespond) BOOL respond;

+ (instancetype)imageMessage:(UIImage *)image
                    platform:(SocialSharePlatform)platform;

+ (instancetype)webMessage:(NSString *)title
               description:(NSString *)description
                thumbImage:(UIImage *)thumbImage
                    webURL:(NSString *)webURL
                  platform:(SocialSharePlatform)platform;

+ (instancetype)videoMessage:(NSString *)title
                 description:(NSString *)description
                  thumbImage:(UIImage *)thumbImage
                    videoURL:(NSString *)videlURL
                    platform:(SocialSharePlatform)platform;

+ (instancetype)appMessage:(NSString *)title
               description:(NSString *)description
                thumbImage:(UIImage *)thumbImage
                  storeURL:(NSString *)storeURL
                  platform:(SocialSharePlatform)platform;

+ (instancetype)musicMessage:(NSString *)title
                 description:(NSString *)description
                  thumbImage:(UIImage *)thumbImage
                    musicURL:(NSString *)musicURL
                    platform:(SocialSharePlatform)platform;

+ (instancetype)textMessage:(NSString *)text
                   platform:(SocialSharePlatform)platform;

+ (instancetype)payMessage:(id )option
                  platform:(SocialSharePlatform)platform;

+ (instancetype)authMessage;
@end


@interface SocialShareResp : NSObject

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, assign) SocialShareResultCode result;

@end

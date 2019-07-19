//
//  SocialShareMessage.m
//  Superior
//
//  Created by Dao on 2018/7/26.
//  Copyright © 2018 淘菜猫. All rights reserved.
//

#import "SocialShareMessage.h"

#import "SocialShareMessage+WeChat.h"
#import "SocialShareMessage+QQ.h"


@interface SocialShareMessage ()


@end


@implementation SocialShareMessage
- (id)copyWithZone:(NSZone *)zone{
    SocialShareMessage *obj = [SocialShareMessage allocWithZone:zone];
    obj.title = self.title;
    obj.desc = self.desc;
    obj.thumbImage = self.thumbImage;
    obj.url = self.url;
    obj.platform = self.platform;
    obj.shareType = self.shareType;
    obj.delegate = self.delegate;
    obj.respondBlock = [self.respondBlock copy];
    return obj;
}
+ (SocialShareMessage *)instance{
    return [[self alloc] init];
}

+ (instancetype)message:(NSString *)title description:(NSString *)description image:(UIImage *)image url:(NSString *)url platform:(SocialSharePlatform)platform shareType:(SocialShareType)shareType{
    SocialShareMessage *instance = self.instance;

    instance.title = title;
    instance.desc = description;
    instance.thumbImage = image;
    instance.url = url;
    instance.shareType = shareType;
    instance.platform = platform;
    return instance;
}

+ (instancetype)imageMessage:(UIImage *)image platform:(SocialSharePlatform)platform{
    return [self message:nil description:nil image:image url:nil platform:platform shareType:SocialShareTypeImage];
}

+ (instancetype)webMessage:(NSString *)title description:(NSString *)description thumbImage:(UIImage *)thumbImage webURL:(NSString *)webURL platform:(SocialSharePlatform)platform{
    return [self message:title description:description image:thumbImage url:webURL platform:platform shareType:SocialShareTypeWeb];
}

+ (instancetype)videoMessage:(NSString *)title description:(NSString *)description thumbImage:(UIImage *)thumbImage videoURL:(NSString *)videlURL platform:(SocialSharePlatform)platform{
    return [self message:title description:description image:thumbImage url:videlURL platform:platform shareType:SocialShareTypeVideo];
}

+ (instancetype)appMessage:(NSString *)title description:(NSString *)description thumbImage:(UIImage *)thumbImage storeURL:(NSString *)storeURL platform:(SocialSharePlatform)platform{
    return [self message:title description:description image:thumbImage url:storeURL platform:platform shareType:SocialShareTypeApp];
}
+ (instancetype)musicMessage:(NSString *)title description:(NSString *)description thumbImage:(UIImage *)thumbImage musicURL:(NSString *)musicURL platform:(SocialSharePlatform)platform{
    return [self message:title description:description image:thumbImage url:musicURL platform:platform shareType:SocialShareTypeMusic];
}

+ (instancetype)textMessage:(NSString *)text platform:(SocialSharePlatform)platform{
    return [self message:text description:nil image:nil url:nil platform:platform shareType:SocialShareTypeText];
}

+ (instancetype)payMessage:(id)option platform:(SocialSharePlatform)platform{
   SocialShareMessage *msg = [self message:nil description:nil image:nil url:nil platform:platform shareType:SocialShareTypePay];
    msg.option = option;
    return msg;
}

+ (instancetype)authMessage{
    return [self message:nil description:nil image:nil url:nil platform:SocialShareMessage_Unknow shareType:SocialShareTypeAuth];
}

- (id)message{

    id message = nil;
    switch (self.platform) {
        case SocialSharePlatform_WeChat_Session:
        case SocialSharePlatform_WeChat_Timeline:
            message = [self WeChatMessage];
            break;
        case SocialSharePlatform_QQ_Session:
        case SocialSharePlatform_QQ_Zone:
            message = [self QQMessage];
            break;
        case SocialShareMessage_Unknow:
            NSLog(@"SocialShareMessage 未选择分享渠道");
            break;
    }

    return message;
}
@end

@implementation SocialShareResp



@end

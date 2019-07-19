//
//  SocialShareMessage+WeChat.m
//  Superior
//
//  Created by Dao on 2018/7/27.
//  Copyright © 2018 淘菜猫. All rights reserved.
//

#import "SocialShareMessage+WeChat.h"

@implementation SocialShareMessage (WeChat)

- (BaseReq *)WeChatMessage{
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    switch (self.platform) {
        case SocialSharePlatform_WeChat_Session:
            req.scene = WXSceneSession;
            break;
        case SocialSharePlatform_WeChat_Timeline:
            req.scene = WXSceneTimeline;
            break;
        default:
            req.scene = WXSceneFavorite;
            break;
    }

    WXMediaMessage *message = [WXMediaMessage message];
    message.title = self.title;
    message.description = self.desc;
    message.thumbData = UIImagePNGRepresentation(self.thumbImage);

    switch (self.shareType) {
        case SocialShareTypeText:
            req.text = self.title;
            req.bText = YES;
            break;
        case SocialShareTypeImage:{
            WXImageObject *obj = [WXImageObject object];
            obj.imageData = message.thumbData;
            message.mediaObject = obj;
        }
            break;
        case SocialShareTypeWeb:{
            WXWebpageObject *obj = [WXWebpageObject object];
            obj.webpageUrl = self.url;
            message.mediaObject = obj;
        }
            break;
        case SocialShareTypeApp:{
            WXAppExtendObject *obj = [WXAppExtendObject object];
            obj.url = self.url;
            message.mediaObject = obj;
        }
            break;
        case SocialShareTypeMusic:{
            WXMusicObject *obj = [WXMusicObject object];
            obj.musicUrl = self.url;
            message.mediaObject = obj;
        }
            break;
        case SocialShareTypeVideo:{
            WXVideoObject *obj = [WXVideoObject object];
            obj.videoUrl = self.url;
            message.mediaObject = obj;
        }
            break;
        case SocialShareTypePay:{
            PayReq *payReq = [[PayReq alloc] init];
            payReq.partnerId = self.option[@"partnerid"];
            payReq.prepayId = self.option[@"prepayid"];
            payReq.nonceStr = self.option[@"noncestr"];
            payReq.timeStamp = [self.option[@"timestamp"] unsignedIntValue];
            payReq.package = self.option[@"package"];
            payReq.sign = self.option[@"sign"];
            return payReq;
        }
            break;
        case SocialShareTypeAuth:
            break;
    }

    req.message = message;

    return req;
}

@end

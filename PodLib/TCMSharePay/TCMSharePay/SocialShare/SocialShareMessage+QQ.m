//
//  SocialShareMessage+QQ.m
//  Superior
//
//  Created by Dao on 2018/7/27.
//  Copyright © 2018 淘菜猫. All rights reserved.
//

#import "SocialShareMessage+QQ.h"
#import <TencentOpenAPI/TencentOpenAPI/QQApiInterface.h>

#import <TencentOpenAPI/TencentOpenAPI/TencentOAuth.h>

@implementation SocialShareMessage (QQ)

- (id)QQMessage{
    QQApiObject *obj = nil;
    switch (self.shareType) {
        case SocialShareTypeText:
            obj = [QQApiTextObject objectWithText:self.title];
            break;
        case SocialShareTypeImage:
            obj = [QQApiImageObject objectWithData:UIImagePNGRepresentation(self.thumbImage)
                                  previewImageData:UIImagePNGRepresentation(self.thumbImage)
                                             title:self.title
                                       description:self.desc];
            break;
        case SocialShareTypeWeb:
        case SocialShareTypeApp:
            obj = [QQApiNewsObject objectWithURL:[NSURL URLWithString:self.url]
                                           title:self.title
                                     description:self.desc
                                previewImageData:UIImagePNGRepresentation(self.thumbImage)];
            break;
        case SocialShareTypeMusic:
        case SocialShareTypeVideo:
            obj = [QQApiVideoObject objectWithURL:[NSURL URLWithString:self.url]
                                            title:self.title
                                      description:self.desc
                                 previewImageData:UIImagePNGRepresentation(self.thumbImage)];
            break;
        case SocialShareTypeAuth:
            return @[kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,
                     kOPEN_PERMISSION_ADD_SHARE,
                     kOPEN_PERMISSION_GET_INFO,
                     kOPEN_PERMISSION_GET_USER_INFO,
                     kOPEN_PERMISSION_GET_VIP_INFO,
                     kOPEN_PERMISSION_ADD_TOPIC];
            break;
        default:
            break;
    }
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:obj];

    return req;
}

@end

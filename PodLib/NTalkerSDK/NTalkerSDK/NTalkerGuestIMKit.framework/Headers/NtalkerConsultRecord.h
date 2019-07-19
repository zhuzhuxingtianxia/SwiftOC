//
//  NtalkerConsultRecord.h
//  NTalkerGuestIMKit
//
//  Created by wzh on 2018/5/31.
//  Copyright © 2018年 NTalker. All rights reserved.
//咨询记录模型

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NtalkerConsultRecord : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *settingId;
@property (nonatomic, copy) NSString *lastMessageText;
@property (nonatomic, copy) NSString *lastTime;
@property (nonatomic, copy) NSString *unreadCount;
@property (nonatomic, assign) BOOL isPlatform;

/** 头像图片 */
@property (strong,nonatomic) UIImage *iconImage;

+ (instancetype)consultRecordWithDict:(NSDictionary *)dict;
@end

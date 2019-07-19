//
//  NtalkerLeaveMsgSetInfoModel.h
//  NtalkerIMLib
//
//  Created by NTalker-zhou on 17/8/24.
//  Copyright © 2017年 ios_develop. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NtalkerLeaveMsgSetInfoModel : NSObject
//int  打开方式 0：在新的页面打开（默认）  1：在聊窗内打开
@property (assign, nonatomic) NSInteger open_type;
//留言开关 0：关闭  1：开启
@property (assign, nonatomic) NSInteger useable;
//公告开关0:关闭  1：开启
@property (assign, nonatomic) NSInteger isNotice;
//公告内容
@property (strong, nonatomic) NSString *noticeContent;
//留言详细
@property (strong, nonatomic) NSMutableArray *detailArr;
//自定义的留言地址
@property (strong, nonatomic) NSString *url;

//自定义方案 1是系统方案  2是通过自定义的链接地址进行留言
@property (assign, nonatomic) NSInteger plan;

@end

//
//  NtalkerLeaveMessageController.h
//  NTalkerGuestIMKit
//
//  Created by wzh on 2018/3/31.
//  Copyright © 2018年 NTalker. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^closeButtonDidClickBlcok)(void);


@interface NtalkerLeaveMessageController : UITableViewController
@property (nonatomic, copy) NSString *siteId;
@property (nonatomic, copy) closeButtonDidClickBlcok closeBlock;
@property (nonatomic, strong) NSString *fromClass;
///记录SDK使用方导航栏状态
@property(nonatomic,getter=isNavigationBarHidden) BOOL navigationBarHidden;

+ (void)getLeaveMsgConfigureInfo:(void (^)(BOOL isSuccess))block;

@end

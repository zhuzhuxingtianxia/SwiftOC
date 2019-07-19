//
//  NtalkerLeaveMsgDetailModel.h
//  NtalkerIMLib
//
//  Created by NTalker-zhou on 17/8/24.
//  Copyright © 2017年 ios_develop. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NtalkerLeaveMsgDetailModel : NSObject

///是否显示 0：不显示 1：显示
@property (assign, nonatomic) NSInteger show;
///是否显示必填 0：不显示  1：显示
@property (assign, nonatomic) NSInteger isRequired;
///访客端展示名称
@property (strong, nonatomic) NSString *title;
///字段默认显示提示语
@property (strong, nonatomic) NSString *value;
///字段输入错误提示语
@property (strong, nonatomic) NSString *message;





@end

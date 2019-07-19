//
//  NtalkerDeviceModel.h
//  NengCloud
//
//  Created by mac on 2017/3/2.
//  Copyright © 2017年 NTalker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NtalkerDeviceModel : NSObject

/**
 设备id
 */
@property (strong, nonatomic) NSString *ID;

/**
 设备类型
 */
@property (strong, nonatomic) NSString *deviceType;

/**
 设备型号
 */
@property (strong, nonatomic) NSString *deviceModel;

/**
 设备操作系统
 */
@property (strong, nonatomic) NSString *os;

/**
 设备浏览器
 */
@property (strong, nonatomic) NSString *browse;

@end

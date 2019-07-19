//
//  NtalkerUIConfig.h
//  NTalkerGuestIMKit
//
//  Created by wzh on 2019/1/8.
//  Copyright © 2019 NTalker. All rights reserved.
//UI配置类

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NtalkerUIConfig : NSObject
+ (instancetype)sharedUIConfig;

/**
 状态栏样式
 */
@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;

/**
 导航栏标题颜色
 */
@property (nonatomic, strong) UIColor *navigationTitleColor;

/**
 导航栏标题字体
 */
@property (nonatomic, strong) UIFont *navigationTitleFont;

/**
 导航栏右侧按钮文字颜色
 */
@property (nonatomic, strong) UIColor *navigationRightTitleColor;

/**
 导航栏右侧按钮文字字体
 */
@property (nonatomic, strong) UIFont *navigationRightTitleFont;

/**
 企业名称颜色
 */
@property (nonatomic, strong) UIColor *enterpriseLabelColor;

/**
 企业名称字体
 */
@property (nonatomic, strong) UIFont *enterpriseLabelFont;

/**
 客服名颜色
 */
@property (nonatomic, strong) UIColor *nameLabelColor;

/**
 客服名字体
 */
@property (nonatomic, strong) UIFont *nameLabelFont;

/**
 个性签名颜色
 */
@property (nonatomic, strong) UIColor *signatureLabelColor;

/**
 个性签名字体
 */
@property (nonatomic, strong) UIFont *signatureLabelFont;
/**
 聊天窗左侧文本消息颜色：默认：blackColor
 客服端下行消息默认是有格式的，此设置是在无格式的情况下生效
 */
@property (nonatomic, strong) UIColor *leftChatTextColor;

/**
 聊天窗左侧文本消息字体：默认：[UIFont systemFontOfSize:14.0]
 客服端下行消息默认是有格式的，此设置是在无格式的情况下生效
 */
@property (nonatomic, strong) UIFont *leftChatTextFont;

/**
 聊天窗右侧文本消息颜色：默认：whiteColor
 */
@property (nonatomic, strong) UIColor *rightChatTextColor;

/**
 聊天窗右侧文本消息字体：默认：[UIFont systemFontOfSize:14.0]
 */
@property (nonatomic, strong) UIFont *rightChatTextFont;

/**
 聊天窗输入框字体：默认：[UIFont systemFontOfSize:14.0]）
 */
@property (nonatomic, strong) UIFont *intputBarTextFont;

/**
 是否隐藏自定义主题设置项（内部默认不隐藏）
 */
@property (nonatomic, assign, getter=isHiddenCustomThemeOption) BOOL hiddenCustomThemeOption;

/**
 是否隐藏语音识别波浪（内部默认不隐藏）
 */
@property (nonatomic, assign, getter=isHiddenWaverView) BOOL hiddenWaverView;

/**
 下拉刷新控件颜色
 */
@property (nonatomic, strong) UIColor *refreshColor;

/**
 视频播放进度条颜色
 */
@property (nonatomic, strong) UIColor *videoPlayProgressBarColor;

/**
 视频录制进度条颜色
 */
@property (nonatomic, strong) UIColor *videoRecordingProgressBarColor;

/**
 视频上传进度条颜色
 */
@property (nonatomic, strong) UIColor *videoUploadProgressBarColor;
/**
 视频上传进度条背景颜色
 */
@property (nonatomic, strong) UIColor *videoUploadProgressBarBackgroundColor;

/**
 键盘类型：0：重构版； 1：经典版 （默认为0）
 */
@property (nonatomic, assign) NSUInteger keyBoardType;
@end



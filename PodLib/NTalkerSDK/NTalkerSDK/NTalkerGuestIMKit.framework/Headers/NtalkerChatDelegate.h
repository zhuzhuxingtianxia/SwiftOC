//
//  NtalkerChatDelegate.h
//  NtalkerIMKit
//
//  Created by wzh on 2017/12/25.
//  Copyright © 2017年 ios_develop. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class NTalkerChatTableHeaderModel;

@protocol NtalkerChatDelegate <NSObject>

@optional
/**
 聊天窗口导航栏

 @param navigationBar 导航栏
 */
- (void)ntalker_navigationBar:(UIView *)navigationBar;
/**
 重定义实现聊窗商品头信息

 @param model 商品信息model
 @parm cell 
 @param action 发送商品信息的点击事件
 @return 返回被定义的view
 */
- (UIView *)ntalker_reSetProductInfoViewWithGoodsInfo:(NTalkerChatTableHeaderModel *)model cell:(UITableViewCell *)cell sendGoodsInfoSelector:(SEL)action;


/**
 自定义cell

 @param tableView tableView
 @param message message description
 @param indexPath indexPath description
 @return return value description
 */
- (UITableViewCell *)ntalker_customCellWithTableView:(UITableView *)tableView message:(NSString *)message indexPath:(NSIndexPath *)indexPath;

/**
 自定义cell高度

 @param tableView tableView description
 @param indexPath indexPath description
 @return return value description
 */
- (CGFloat)ntalker_customCellHeightWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

/**
 自定义cell点击监听

 @param tableView tableView description
 @param message message description
 @param indexPath indexPath description
 */
- (void)ntalker_customCellTableView:(UITableView *)tableView message:(NSString *)message didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
#pragma mark -
/**
 重定义实现聊窗 + 号扩展内容
 
 @return 扩展内容 例如：
 @[@{@"picName": @"图片-(1)",@"highLightPicName": @"图片hover",@"name": @"图片1"},
 @{@"picName": @"图片-(1)",@"highLightPicName": @"图片hover",@"name": @"图片2"}];
 */
- (NSArray *)ntalker_reSetExtendContentView;

/**
 重定义实现聊窗 + 号扩展内容点击时间监听
 
 @param index 当前点击的位置
 */
- (void)ntalker_extendItemDidSelectItemAtIndex:(NSInteger)index viewController:(UIViewController *)viewController;

/**
 聊天消息中的链接点击事件的监听
 
 @param urlString 消息内容中的url
 */
- (void)ntalker_messageOpenURL:(NSString *)urlString;

/**
 自定义实现 点击超媒体消息链接跳转的操作
 
 @param URLString 链接字符串
 */
- (void)ntalker_hypermediaMessageOpenURL:(NSString *)URLString;

/**
 自定义实现 点击超媒体消息其他跳转操作
 
 @param parameter 参数
 */
- (void)ntalker_hypermediaMessageOpenPageWithParameter:(id)parameter;

/**
 聊天窗口关闭按钮点击监听
 */
- (void)ntalker_closeChatButtonDidSelect;

/**
 聊天窗口返回按钮点击监听
 */
- (void)ntalker_goBackButtonDidSelect;
#pragma mark - 聊天窗生命周期监听方法
- (void)ntalker_viewWillAppear:(BOOL)animated;
- (void)ntalker_viewDidAppear:(BOOL)animated;
- (void)ntalker_viewWillDisappear:(BOOL)animated;
- (void)ntalker_viewDidDisappear:(BOOL)animated;
/**
 侧滑返回手势是否启用

 @return 默认YES
 */
- (BOOL)ntalker_interactivePopGestureRecognizerEnabled;
@end

//
//  NtalkerEventModel.h
//  NtalkerIMLib
//
//  Created by mac on 2017/8/15.
//  Copyright © 2017年 ios_develop. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma MARK : - 事件
@interface NtalkerEventModel : NSObject

/**
 页面唯一标识(当前view控制器的功能)
 */
@property (nonatomic, copy) NSString *pgid;

/**
 "页面元素位置"
 */
@property (nonatomic, copy) NSString *eh;

/**
 "页面元素位置"
 */
@property (nonatomic, copy) NSString *ep;

/**
 页面元素位置索引"
 */
@property (nonatomic, copy) NSString *ei;

/**
 "事件值(加入购物车、提交订单)"
 */
@property (nonatomic, copy) NSString *ev;

/**
 事件类型(click)
 */
@property (nonatomic, copy) NSString *et;

@end

#pragma mark:- WEB
@interface NtalkerWebModel : NSObject

/**
 页面唯一标识(当前view控制器的功能) 必须是英文
 */
@property (nonatomic, copy) NSString *pgid;

/**
 页面标题
 */
@property (nonatomic, copy) NSString *ttl;

/**
 页面等级，web端不需要，移动端需要上传数字 1:首页 2:列表页 3:商品页 4:购物车页 5:订单页 6:支付页 7支付成功页
 */
@property (nonatomic, copy) NSString *lev;


@end

#pragma MARK: - 订单
@interface NtalkerOrderModel : NSObject

/**
 订单id
 */
@property (nonatomic, copy) NSString *oi;

/**
 订单价格
 */
@property (nonatomic, copy) NSString *op;

@end

#pragma MARK: - 商品
@interface NtalkerProductModel : NSObject

/**
 商品id
 */
@property (nonatomic, copy) NSString *prid;
/**
 商品名称
 */
@property (nonatomic, copy) NSString *pn;
/**
 市场价格
 */
@property (nonatomic, copy) NSString *mp;
/**
 网站价格
 */
@property (nonatomic, copy) NSString *sp;
/**
 商品图片链接
 */
@property (nonatomic, copy) NSString *iu;
/**
 商品分类名称
 */
@property (nonatomic, copy) NSString *ca;
/**
 商品品牌名称
 */
@property (nonatomic, copy) NSString *br;

@end

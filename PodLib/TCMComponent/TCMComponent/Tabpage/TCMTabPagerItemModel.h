//
//  TCMTabPagerItemModel.h
//  Pods-ComponentDemo
//
//  Created by ZZJ on 2019/7/11.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, TCMViewPagerViewType) {
    TCMViewPagerViewTypeNoScroll = 0,//default 总宽度为屏幕宽度，不可滚动，每个item的宽度，根据item的个数确定。适合item数比较少的情况
    TCMViewPagerViewTypeCanScroll//每个item的宽度确定，超过屏幕可以滑动。适合item数比较多的情况。
};

typedef NS_ENUM(NSUInteger, TCMViewPagerMaskPositionType) {
    TCMViewPagerMaskPositionTypeNone = 0,//maskView占据整个高度
    TCMViewPagerMaskPositionTypeTop,//maskView的位置 顶部
    TCMViewPagerMaskPositionTypeBottom//maskView的位置 底部
};
typedef NS_ENUM(NSUInteger, TCMTabPagerItemType) {
    TCMTabPagerItemTypeForText = 0,
    TCMTabPagerItemTypeForImage,
    TCMTabPagerItemTypeForTextAndImage
};

typedef NS_ENUM(NSUInteger, TCMTabPagerItemImageType) {
    TCMTabPagerItemImageTypeForLocal = 0,//本地图片
    TCMTabPagerItemImageTypeForUrl//网络图片
};


@interface TCMTabPagerConfigModel : NSObject
/** 背景色 */
@property (nonatomic, strong) NSString *topViewBgColor;
/** 第一遮罩颜色 */
@property (nonatomic, strong) NSString *maskColor;
/** 第一遮罩高度 默认和父类一样高*/
@property (nonatomic, assign) CGFloat maskHeight;

/** 第一遮罩宽度 默认和父类一样宽*/
@property (nonatomic, assign) CGFloat maskWidth;
/** 是否需要第二遮罩 */
@property (nonatomic, assign) BOOL needSecondaryMask;

/** 第二遮罩颜色 默认和父类一样宽高 可以继续扩展*/
@property (nonatomic, strong) NSString *secondaryMaskColor;

/** 第二遮罩层颜色的alpha值 */
@property (nonatomic, assign) CGFloat secondaryMaskColorAlpha;

/** 遮罩位置 0:占据整个高度 1:顶部 2: 底部 */
@property (nonatomic, assign) TCMViewPagerMaskPositionType maskPositionType;

/** 显示类型  0:总宽度为屏幕宽度，不可滚动，每个item的宽度，根据item的个数确定。适合item数比较少的情况 1:每个item的宽度确定，超过屏幕可以滑动。适合item数比较多的情况 */
@property (nonatomic, assign) TCMViewPagerViewType type;

/******** 定义单个item ********/

/** 每一个item显示的宽度 */
@property (nonatomic, assign) CGFloat itemWidth;

/** 显示模式 0: 文本 1: 图片 2: 图文混排 */
@property (nonatomic, assign) TCMTabPagerItemType itemType;

/** 图片类型  0: 本地图片  1:网络图片*/
@property (nonatomic, assign) TCMTabPagerItemImageType imageType;
/** 未选中标题颜色 default #666666 */
@property (nonatomic, strong) NSString *normalTitleColor;

/** 选中标题颜色 default #3d3d3d*/
@property (nonatomic, strong) NSString *selectTitleColor;
/** 未选中字体大小 */
@property (nonatomic, copy) UIFont *fontSize;

/** 选中字体大小*/
@property (nonatomic, copy) UIFont *selectFontSize;


@end

///////////////////////////////

@interface TCMTabPagerConfigItemModel : NSObject
/** 标题 */
@property (nonatomic, strong) NSString *title;

/** 未选中图标 defult ic_element_tabbar_home_normal*/
@property (nonatomic, strong) NSString *normalIconName;

/** 选中图标 defult ic_element_tabbar_home_pressed*/
@property (nonatomic, strong) NSString *selectIconName;

//vc的实例
@property (nonatomic, strong) UIViewController *vcInstance;

@end

NS_ASSUME_NONNULL_END

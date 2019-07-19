//
//  thybridNavigationOption.h
//  AFNetworking
//
//  Created by Dao on 2018/12/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, thybridNavigationOptionTab) {
    thybridNavigationOptionTabUnkonw = -1,
};

@interface thybridNavigationOption : NSObject

/** popToRoot: popToRootViewController */
@property (nonatomic, assign) BOOL popToRoot;
/** pop: popTo标识【push\pop通用】 */
@property (nonatomic, assign) BOOL pop;
/** animate: animated */
@property (nonatomic, assign) BOOL animated;
/** switchTab:  设置切换Tabbar */
@property (nonatomic, assign) thybridNavigationOptionTab selectedIndex;
/** title: 导航栏名称 */
@property (nonatomic, copy) NSString *title;
/** 替换当前的viewController */
@property (nonatomic, assign) BOOL replace;

/** url:目标weex.js */
@property (nonatomic, copy) NSString *javascriptUrl;
/** 原数据 */
@property (nonatomic, copy) NSDictionary *option;

/** 标题颜色 */
@property (nonatomic, copy) UIColor *titleColor;
@property (nonatomic, copy) NSString *titleColorHex;
@property (nonatomic, copy, class) NSString *titleColorHex;
/** 导航栏颜色 */
@property (nonatomic, copy) UIColor *barColor;
@property (nonatomic, copy) NSString *barColorHex;
@property (nonatomic, copy, class) NSString *barColorHex;


+ (instancetype)objectWithKeyValues:(NSDictionary *)ids;

@end

NS_ASSUME_NONNULL_END

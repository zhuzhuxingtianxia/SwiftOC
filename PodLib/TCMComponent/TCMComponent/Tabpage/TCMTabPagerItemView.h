//
//  TCMTabPagerItemView.h
//  Pods-ComponentDemo
//
//  Created by ZZJ on 2019/7/11.
//

#import <UIKit/UIKit.h>
#import "TCMTabPagerItemModel.h"

NS_ASSUME_NONNULL_BEGIN
typedef void (^TabPagerItemViewSelectCallBack)(NSInteger tag);

@interface TCMTabPagerItemView : UIView
/* 配置数据 */
@property (nonatomic,strong)TCMTabPagerConfigModel *pagerConfigModel;

- (void)renderUIWithDataModel:(TCMTabPagerConfigItemModel *)dataModel;

- (void)settingTabSelect:(BOOL)select;

- (void)addSelectedCallBack:(TabPagerItemViewSelectCallBack)callback;

@end

NS_ASSUME_NONNULL_END

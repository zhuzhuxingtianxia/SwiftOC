//
//  TCMTabPagerView.h
//  Pods-ComponentDemo
//  牛逼的分段控制器：https://github.com/pujiaxin33/JXSegmentedView
// 和：https://github.com/pujiaxin33/JXCategoryView
//  Created by ZZJ on 2019/7/11.
//  分段控制器

#import <UIKit/UIKit.h>
#import "TCMTabPagerItemView.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^TCMViewPagerViewScrollViewBlock)(UIScrollView *scrollView);
typedef void (^TCMViewPagerViewItemClickBlock)(NSInteger tag);

@interface TCMTabPagerView : UIView

/* 配置数据 */
@property (nonatomic,strong)TCMTabPagerConfigModel *pagerConfigModel;

@property (nonatomic, strong) UIScrollView *tabScroller;
@property (nonatomic, strong) UIView *maskView;

- (void)renderUIWithArray : (NSArray<TCMTabPagerConfigItemModel*> *)dataArray;

- (void)tabItemSelected:(NSInteger)index;

- (void)addScrollViewBlock : (TCMViewPagerViewScrollViewBlock) block;

- (void)addItemClickBlock : (TCMViewPagerViewItemClickBlock) block;

@end

NS_ASSUME_NONNULL_END

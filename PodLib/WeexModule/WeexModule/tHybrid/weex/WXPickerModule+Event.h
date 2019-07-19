//
//  WXPickerModule+Event.h
//  AFNetworking
//
//  Created by ZZJ on 2018/12/5.
// 解决iOS11,picker组件不回调问题;
// input类型为dated时，也需要扩展WXDatePickerManager

#import "WXPickerModule.h"

NS_ASSUME_NONNULL_BEGIN

@interface WXPickerModule (Event)<UIGestureRecognizerDelegate>

@end

NS_ASSUME_NONNULL_END

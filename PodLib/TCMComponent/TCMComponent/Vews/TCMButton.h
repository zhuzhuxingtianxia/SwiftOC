//
//  TCMButton.h
//  Pods-ComponentDemo
//
//  Created by ZZJ on 2019/7/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, ADButtonImageAlignmentType) {
    ADButtonImageAlignmentTypeLeft   = 0,
    ADButtonImageAlignmentTypeTop    = 1,
    ADButtonImageAlignmentTypeBottom = 2,
    ADButtonImageAlignmentTypeRight  = 3,
};

/**
 自定义图片方向的Button(支持xib)
 
 * imageAlignmentType 设定图片方向，为可在xib中直观显示故用NSInteger类型
 * spaceBetweenTitleAndImage 设定图片和文字距离
 */

//IB_DESIGNABLE
@interface TCMButton : UIButton
@property (nonatomic,assign) IBInspectable NSInteger imageAlignmentType;

@property (nonatomic,assign) IBInspectable CGFloat spaceBetweenTitleAndImage;
@end

NS_ASSUME_NONNULL_END

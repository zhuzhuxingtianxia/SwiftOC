#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "NSObject+Bundle.h"
#import "NSString+AES.h"
#import "TCMBase.h"
#import "TCMCheck.h"
#import "TCMFileManager.h"
#import "TCMRoute.h"
#import "UICollectionReusableView+TCMLayer.h"
#import "UIScrollView+TCMEdgePanGesture.h"
#import "UIView+TCMBorderSide.h"
#import "UIView+TCMEdgeSlide.h"
#import "UIView+TCMGradient.h"
#import "UIView+TransformPI.h"

FOUNDATION_EXPORT double TCMBaseVersionNumber;
FOUNDATION_EXPORT const unsigned char TCMBaseVersionString[];


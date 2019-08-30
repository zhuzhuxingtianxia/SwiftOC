//
//  TCMComponent.h
//
//  Created TCMComponent
//  Copyright (c) on 2019/7/10..
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
// 用于添加一些基础功能组件，如：轮播图、tabpage、跑马灯、自定义view等效果

#import <Foundation/Foundation.h>

#if __has_include(<TCMComponent/TCMComponent.h>)

FOUNDATION_EXPORT double TCMComponentVersionNumber;
FOUNDATION_EXPORT const unsigned char TCMComponentVersionString[];

#import <TCMComponent/TCMBannerView.h>
#import <TCMComponent/TCMPageView.h>
#import <TCMComponent/TCMTabPagerView.h>
#import <TCMComponent/TCMTabPagerItemModel.h>
#import <TCMComponent/TCMRunLabel.h>
//#import <TCMComponent/TCMButton.h>

#else

#import "TCMBannerView.h"
#import "TCMPageView.h"
#import "TCMTabPagerView.h"
#import "TCMTabPagerItemModel.h"
#import "TCMRunLabel.h"
//#import "TCMButton.h"

#endif

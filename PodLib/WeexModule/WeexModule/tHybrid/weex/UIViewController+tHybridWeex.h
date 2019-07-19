//
//  UIViewController+Weex.h
//  Weex
//
//  Created by Dao on 2018/1/18.
//  Copyright © 2018年 Taocaimall. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "tHybridSpringReceiveProtocol.h"
#import "tHybridWeexProtocol.h"
#import "thybridNavigationOption.h"

@interface thybridViewController : UIViewController<tHybridWeexProtocol>

@end

@interface UIViewController (tHybridWeex) < tHybridSpringReceiveProtocol>


/**
 * 渲染Weex
 */
- (void)renderWeex;
- (void)renderWeexWithURL:(NSURL *)url;


/**
 重新渲染[用于渲染失败]
 */
- (void)rendererWeex;

/**
 * 渲染Weex并携带参数
 *
 * @param options 渲染所需参数
 */
- (void)renderWeexWithOptions:(NSObject *)options;
- (void)refreshWeexInstance;


- (void)springWithOption:(thybridNavigationOption *)option;
- (void)springWithURL:(NSString *)url option:(NSDictionary *)option;

- (void)pop:(thybridNavigationOption *)option;

- (void)resetNavigationBar;

@end

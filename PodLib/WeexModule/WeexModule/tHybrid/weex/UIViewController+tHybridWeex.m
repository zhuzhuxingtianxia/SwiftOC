//
//  UIViewController+Weex.m
//  Weex
//
//  Created by Dao on 2018/1/18.
//  Copyright © 2018年 Taocaimall. All rights reserved.
//

#import "UIViewController+tHybridWeex.h"

#import "NSURL+tHybrid.h"
#import <objc/runtime.h>
#import "Masonry.h"

#import "tHybridKitModule.h"

#import <WXSDKManager.h>

#import "thybridBackgroundView.h"


@interface thybridViewController()

@property (nonatomic, strong) thybridBackgroundView *privateContentView;

@property (nonatomic, strong) UIView *createView;

@end


@implementation thybridViewController
@synthesize weexInstance;
@synthesize weexView;
@synthesize weexUrl;
@synthesize options;
@synthesize contentView;
@synthesize renderOption;
@synthesize noption;

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.renderOption = thybridRenderOptionUnknown;
    if (self.weexUrl) {
        [self renderWeex];
    }
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self rendererWeex];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (self.renderOption == thybridRenderOptionOnFail) {
        [self renderOption];
    }
    [self.weexInstance fireGlobalEvent:@"viewappear" params:nil];
    if (self.renderOption & thybridRenderOptionOnCreate) {
        [[WXSDKManager bridgeMgr] fireEvent:self.weexInstance.instanceId ref:WX_SDK_ROOT_REF type:@"viewappear" params:nil domChanges:nil];
    }

    self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self.navigationController;
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[WXSDKManager bridgeMgr] fireEvent:self.weexInstance.instanceId ref:WX_SDK_ROOT_REF type:@"viewdisappear" params:nil domChanges:nil];
}

- (void)renderFinish:(UIView *)view{
    if (self.options) {
        [self refreshWeexInstance];
    }
    //加载完成
    self.privateContentView.loadingStatus = THYBRID_LOADING_STATUS_RENDER_FINISH;
}
- (void)onJSRuntimeException:(WXJSExceptionInfo *)jsException{
    if (jsException.errorCode.integerValue == -2013) {
        self.privateContentView.loadingStatus = THYBRID_LOADING_STATUS_FILE_EXECUTION_FAILED;
        [self.createView removeFromSuperview];
    }
}
- (void)onFailed:(NSError *)error{
    if (error.code == -2205) {
        self.privateContentView.loadingStatus = THYBRID_LOADING_STATUS_NETWORK_ERROR;
    } else if(error.code == -2202){
        self.privateContentView.loadingStatus = THYBRID_LOADING_STATUS_LOAD_FAILED;
    } else if (error.code == 404) {
        self.privateContentView.loadingStatus = THYBRID_LOADING_STATUS_NO_FILE;
    }
}


- (void)onCreate:(UIView *)view{
    if (self.contentView) {
        while (self.contentView.subviews.count) {
            [self.contentView.subviews.lastObject removeFromSuperview];
        }
        [self.contentView addSubview:view];
    } else {
        [self.view addSubview:view];
    }

    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    [view.superview layoutSubviews];
    self.weexInstance.frame = view.frame;
    self.createView = view;
    self.privateContentView.loadingStatus = THYBRID_LOADING_STATUS_LOAD_FINISH;
}

- (void)resetNavigationBar{
    self.privateContentView.title = self.navigationItem.title;
}


- (thybridBackgroundView *)privateContentView{
    if (!_privateContentView) {
        thybridBackgroundView *backgroundView = [thybridBackgroundView objectWithHandler:self];
        backgroundView.tag = THYBRID_BACKGROUND_VIEW_TAG;

        [self.view addSubview:backgroundView];
        [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.mas_offset(0);
        }];

        UITabBarController<UIGestureRecognizerDelegate> *tabBarController = (id)self.tabBarController;
        if (!tabBarController || (![tabBarController.viewControllers indexOfObject:self] && [tabBarController respondsToSelector:@selector(gestureRecognizerShouldBegin:)] && [tabBarController gestureRecognizerShouldBegin:tabBarController.navigationController.interactivePopGestureRecognizer])) {

            UIImage *image = nil;
            NSBundle *bundle = [NSBundle bundleForClass:[self class]];
            NSURL *url = [bundle URLForResource:@"tHybridKit" withExtension:@"bundle"];
            if (url) {
                NSBundle *targetBundle = [NSBundle bundleWithURL:url];
                image = [UIImage imageNamed:@"navigation_goback.png" inBundle:targetBundle compatibleWithTraitCollection:nil];
                image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            }

            UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:image style:(UIBarButtonItemStylePlain) target:self action:@selector(leftBarButtonAction)];
            backgroundView.navigationItem.leftBarButtonItem = item;
        }

        /*
         UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Update" style:(UIBarButtonItemStylePlain) target:self action:@selector(rightBarButtonAction)];
         backgroundView.navigationItem.rightBarButtonItem = item;
         */

        backgroundView.handler = self;
        _privateContentView = backgroundView;
    }
    [self.view addSubview:_privateContentView];

    return _privateContentView;
}
- (void)leftBarButtonAction{
    thybridNavigationOption *option = [[thybridNavigationOption alloc] init];

    [self pop:option];
}

- (void)rightBarButtonAction{
    [self renderWeex];
}
- (void)dealloc{
    [self.weexInstance destroyInstance];
}


@end


@interface UIViewController ()<tHybridWeexProtocol>

@property (nonatomic, weak, readonly) thybridBackgroundView *privateContentView;

@property (nonatomic, assign) BOOL pop;

@end

@implementation UIViewController (tHybridWeex)
- (void)springWithURL:(NSString *)url option:(NSDictionary *)option{
    
}
static void* kUIViewController_Pop = &kUIViewController_Pop;
- (void)setPop:(BOOL)pop{
    objc_setAssociatedObject(self, kUIViewController_Pop, @(pop), OBJC_ASSOCIATION_COPY);
}
- (BOOL)pop{
    NSNumber *obj = objc_getAssociatedObject(self, kUIViewController_Pop);
    return obj.boolValue;
}

- (void)renderWeexWithURL:(NSURL *)url{
    self.weexUrl = url;
    [self renderWeex];
}
- (void)renderWeex{
    [self renderWeexWithOptions:self.options];
}
- (void)rendererWeex{
    if (self.renderOption & thybridRenderOptionUnknown ||
        self.renderOption & thybridRenderOptionOnFail ||
        self.renderOption & thybridRenderOptionExecutionFail){
        [self renderWeex];
    }
}


- (void)renderWeexWithOptions:(thybridNavigationOption *)options{
    [self.weexInstance destroyInstance];

    self.edgesForExtendedLayout = UIRectEdgeNone;

    self.weexInstance = [[WXSDKInstance alloc] init];
    self.weexInstance.viewController = self;
    if (self.contentView) {
        CGRect frame = self.contentView.frame;
        frame.origin = CGPointZero;
        self.weexInstance.frame = frame;
    } else {
        self.weexInstance.frame = self.view.frame;
    }

    self.renderOption = thybridRenderOptionOnRendering;
    self.privateContentView.loadingStatus = THYBRID_LOADING_STATUS_LOADING;
    __weak typeof(self) weakSelf = self;
    self.weexInstance.onCreate = ^(UIView *view) {
        weakSelf.renderOption |= thybridRenderOptionOnCreate;

        //进行安全校验，避免出现运行时Crash现象
        [weakSelf.weexView removeFromSuperview];
        weakSelf.weexView = view;
        [weakSelf onCreate:view];
        [[WXSDKManager bridgeMgr] fireEvent:weakSelf.weexInstance.instanceId ref:WX_SDK_ROOT_REF type:@"viewappear" params:nil domChanges:nil];

    };
    self.weexInstance.onFailed = ^(NSError *error) {
        //process failure
        weakSelf.renderOption |= thybridRenderOptionOnFail;
        [weakSelf performSelectorOnMainThread:@selector(onFailed:) withObject:error waitUntilDone:NO];
    };

    self.weexInstance.renderFinish = ^ (UIView *view) {
        //process renderFinish
        weakSelf.renderOption |= thybridRenderOptionOnFinish;
        [weakSelf performSelectorOnMainThread:@selector(renderFinish:) withObject:view waitUntilDone:NO];
    };

    self.weexInstance.onRenderProgress = ^ (CGRect renderRect) {
    };
    self.weexInstance.onJSDownloadedFinish = ^(WXResourceResponse *response, WXResourceRequest *request, NSData *data, NSError *error) {
    };
    self.weexInstance.onJSRuntimeException = ^(WXJSExceptionInfo *jsException) {
        weakSelf.renderOption |= thybridRenderOptionExecutionFail;

        [weakSelf performSelectorOnMainThread:@selector(onJSRuntimeException:) withObject:jsException waitUntilDone:NO];
    };

    NSMutableDictionary *GlobalEvent = [NSMutableDictionary dictionary];
    [GlobalEvent setValue:tHybridKitModule.GlobalEventRefreshInstance forKey:@"GlobalEventRefreshInstance"];

    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:GlobalEvent, @"GlobalEvent", nil];
    [dic setValue:self.title forKey:@"title"];
//    [dic setValue:options.titleColorHex forKey:@"titleColor"];
//    [dic setValue:options.barColorHex forKey:@"barColor"];
   
    [self.weexInstance renderWithURL:self.weexUrl options: dic data:nil];
    self.options = options;
}

- (void)refreshWeexInstance{
    [self.weexInstance fireGlobalEvent:tHybridKitModule.GlobalEventRefreshInstance params:self.options];
}


- (void)springWithOption:(thybridNavigationOption *)option{

    UIViewController *contain = self;
    if (option.selectedIndex != thybridNavigationOptionTabUnkonw) {
        UITabBarController *tabBarViewController = self.tabBarController;
        if (!tabBarViewController) {
            tabBarViewController = self.navigationController.viewControllers.firstObject;
        }
        if (option.selectedIndex < tabBarViewController.viewControllers.count) {
            contain = [tabBarViewController.viewControllers objectAtIndex:option.selectedIndex];
            [tabBarViewController setSelectedViewController:contain];
        }
        [self.navigationController popToRootViewControllerAnimated:YES];
    }

    if (!option.javascriptUrl) {
        return;
    }

    thybridViewController *VC = [[thybridViewController alloc] init];
    VC.view.backgroundColor = [UIColor whiteColor];
    VC.noption = option;

    VC.weexUrl = [NSURL URLWithString:option.javascriptUrl];
    VC.options = option;
    VC.title = option.title;

    [VC resetNavigationBar];
    [VC renderWeex];


    if ([contain isKindOfClass:UINavigationController.class]) {
        [(UINavigationController *)contain pushViewController:VC animated:option.animated];
    } else {
        if (contain.tabBarController) {
            contain.tabBarController.pop = option.pop;
        } else {
            contain.pop = option.pop;
        }

        UINavigationController *navigation = contain.navigationController;
        [navigation pushViewController:VC animated:option.animated];

        if (option.replace) {
            NSMutableArray *array = [navigation.viewControllers mutableCopy];
            [array removeObjectAtIndex:array.count-2];
            [navigation setViewControllers:array animated:YES];
        }
        contain.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)contain.navigationController;
    }
}


/**
 返回堆栈中的某个VC

 @param option pop参数{

 }
 */
- (void)pop:(thybridNavigationOption *)option{
    if (!option || ![option isKindOfClass:thybridNavigationOption.class]) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }


    if (option.popToRoot) {
        [self.navigationController popToRootViewControllerAnimated:option.animated];
        return;
    }


    if ((self.presentedViewController || self.presentingViewController) && self.navigationController.childViewControllers.count == 1) {
        CATransition* transition = [CATransition animation];
        transition.duration = 0.35;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromLeft;

        [self.view.window.layer addAnimation:transition forKey:kCATransition];

        [self dismissViewControllerAnimated:NO completion:^{

        }];
        return;
    }


    if (option.pop) {
        NSArray<UIViewController *> *array = self.navigationController.viewControllers;
        UIViewController *controller = nil;
        for (NSInteger index = array.count -2; index>=0; index--) {
            UIViewController *handler = [array objectAtIndex:index];
            if (handler.pop) {
                controller = handler;
                break;
            }
        }

        if (controller) {
            [self.navigationController popToViewController:controller animated:option.animated];
            return;
        }
    }
    [self.navigationController popViewControllerAnimated:option.animated];

}

- (void)performBlock:(void(^)(void))blocks{
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        blocks();
    }];
}


- (void)resetNavigationBar{

}

- (void)renderFinish:(UIView *)view{

}
- (void)onJSRuntimeException:(WXJSExceptionInfo *)jsException{

}
- (void)onFailed:(NSError *)error{

}

//- (void)onCreate:(UIView *)view{
//
//}

@end

//
//  TCMRoute.m
//  TCMBase
//
//  Created by ZZJ on 2019/7/15.
//

#import "TCMRoute.h"
#import <objc/runtime.h>

@interface TCMRoute ()

@end
@implementation TCMRoute

static TCMRoute *route = nil;
+ (instancetype)route {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        route = [self new];
    });
    return route;
}

+ (UIViewController*)routeWithTarget:(nonnull NSString *)target  params:(NSDictionary<NSString *, id>  *)params{
    
    return [TCMRoute routeWithTarget:target routeStyle:TCMRoutePush params:params];
}

+ (UIViewController*)routeWithTarget:(nonnull NSString *)target routeStyle:(TCMRouteStyle)routeStyle params:(NSDictionary<NSString *, id>  *)params{
    
    if ((!target || target.length == 0)&&routeStyle != TCMRoutePop) {
        NSLog(@"target not nil or emty");
        return nil;
    }
    
    if (routeStyle == TCMRoutePop) {
        return [self routeTypePopWithTarget:target params:params];
    }else if (routeStyle == TCMRouteTab){
        
        return [self routeTypeTabWithTarget:target];
    }
    
    Class<TCMRouteProtocol> protocolClass = NSClassFromString(target);
    
    UIViewController *vcInstance = nil;
    if ([target containsString:@"."]) {
        //swift需要使用Bundle的命名前缀
        vcInstance = [protocolClass routeWithParams:params];
        if (!vcInstance) {
            NSLog(@"swift class not implementation TCMRouteProtocol");
            return nil;
        }
    } else if ([protocolClass respondsToSelector:@selector(routeWithParams:)]){
        vcInstance = [protocolClass routeWithParams:params];
    }else {
        vcInstance = [[NSClassFromString(target) alloc] init];
    }
    
    if (!vcInstance) {
        NSLog(@"%@ file or class not found; if swift please add BundleName.%@",target,target);
        return nil;
    }
    
    if (![vcInstance isKindOfClass:[UIViewController class]]) {
        NSLog(@"routeWithParams: method not return a ViewController Class");
        return nil;
    }
    
    switch (routeStyle) {
        case TCMRoutePush:
            vcInstance.hidesBottomBarWhenPushed = YES;
            [[self currentViewController].navigationController pushViewController:vcInstance animated:YES];
            break;
        case TCMRoutePop:
        {
            
        }
            break;
        case TCMRoutePresent:
        {
            if (vcInstance.navigationController) {
                [[self currentViewController] presentViewController:vcInstance animated:YES completion:^{
                    
                }];
            }else{
                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vcInstance];
                [[self currentViewController] presentViewController:nav animated:YES completion:^{
                    
                }];
            }
            
        }
            break;
        case TCMRouteTab:
        {
            
        }
            break;
            
        default:
            break;
    }
    
    return vcInstance;
    
}

+ (UIViewController *)routeTypePopWithTarget:(nonnull NSString *)target  params:(NSDictionary<NSString *, id>  *)params {
    Class aclass = NSClassFromString(target);
    
    UIViewController *backVC = nil;
    UIViewController *currentVc = [self currentViewController];
    if (currentVc.navigationController) {
        if (aclass) {
            for (UIViewController *vc in currentVc.navigationController.childViewControllers) {
                if ([vc isKindOfClass:[aclass class]]) {
                    backVC = vc;
                    if ([backVC respondsToSelector:@selector(routePopWithParams:)]){
                        [backVC routePopWithParams:params];
                    }
                    [currentVc.navigationController popToViewController:backVC animated:YES];
                    break;
                }
            }
        }else {
            NSArray *childArray = currentVc.navigationController.viewControllers;
            if (childArray.count>1) {
                backVC = currentVc.navigationController.viewControllers[childArray.count-2];
            }
            
            //swift兼容
            NSString *backVCString = NSStringFromClass([backVC class]);
            if ([backVCString containsString:@"."]) {
                [backVC routePopWithParams:params];
                
            }else if ([backVC respondsToSelector:@selector(routePopWithParams:)]){
                
                [backVC routePopWithParams:params];
            }
            [currentVc.navigationController popViewControllerAnimated:YES];
        }
        
        if (!backVC) {
            if ([currentVc.presentingViewController isKindOfClass:[UINavigationController class]]) {
                UINavigationController *nav = (UINavigationController*)currentVc.presentingViewController;
                backVC = nav.viewControllers.lastObject;
            }else if ([currentVc.presentingViewController isKindOfClass:[UITabBarController class]]){
                UITabBarController *tabbarVC = (UITabBarController*)currentVc.presentingViewController;
                if ([tabbarVC.selectedViewController isKindOfClass:[UINavigationController class]]) {
                    backVC = ((UINavigationController*)tabbarVC.selectedViewController).viewControllers.lastObject;
                }else{
                    backVC = tabbarVC.selectedViewController;
                }
                
            }
            
            if ([backVC respondsToSelector:@selector(routePopWithParams:)]){
                [backVC routePopWithParams:params];
            }
            [backVC dismissViewControllerAnimated:YES completion:^{
                
            }];
        }
        
    }else{
        backVC = currentVc;
        if ([backVC respondsToSelector:@selector(routePopWithParams:)]){
            [backVC routePopWithParams:params];
        }
        [backVC dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
    
    return backVC;
}

+ (UIViewController*)routeTypeTabWithTarget:(nonnull NSString *)target {
    UITabBarController *tabbar = [self getTabbarController];
    if (tabbar) {
        __block NSInteger index = -1;
        __block UIViewController *vc = nil;
        [tabbar.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[UINavigationController class]]) {
                UINavigationController *nav = (UINavigationController*)obj;
                if ([nav.viewControllers.firstObject isKindOfClass:NSClassFromString(target)]) {
                    index = idx;
                    vc = nav.viewControllers.firstObject;
                    *stop = YES;
                    return;
                }
            }else{
                if ([obj isKindOfClass:NSClassFromString(target)]) {
                    index = idx;
                    vc = obj;
                    *stop = YES;
                    return;
                }
            }
            
        }];
        if (index>=0) {
            tabbar.selectedIndex = index;
        }
        
        return vc;
    }
    
    return nil;
}

+ (UIViewController *)currentViewController{
    
    UIViewController * currVC = nil;
    UIViewController * Rootvc = [[UIApplication sharedApplication] keyWindow].rootViewController ;
    do {
        if ([Rootvc isKindOfClass:[UINavigationController class]]) {
            UINavigationController * nav = (UINavigationController *)Rootvc;
            UIViewController *v = [nav.viewControllers lastObject];
            currVC = v;
            Rootvc = v.presentedViewController;
            continue;
        }else if([Rootvc isKindOfClass:[UITabBarController class]]){
            UITabBarController * tabVC = (UITabBarController *)Rootvc;
            currVC = tabVC;
            Rootvc = [tabVC.viewControllers objectAtIndex:tabVC.selectedIndex];
            continue;
        }else if ([Rootvc isKindOfClass:[UIViewController class]]){
            currVC = Rootvc;
            Rootvc = nil;
        }
    } while (Rootvc!=nil);
    
    return currVC;
}

+(UITabBarController*)getTabbarController {
    UIViewController * rootVC = [[UIApplication sharedApplication] keyWindow].rootViewController;
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        UITabBarController * tabVC = (UITabBarController *)rootVC;
        return tabVC;
    }else if ([rootVC isKindOfClass:[UINavigationController class]]){
        UINavigationController * nav = (UINavigationController *)rootVC;
        UIViewController *vc = nav.viewControllers.firstObject;
        if ([vc isKindOfClass:[UITabBarController class]]) {
            return (UITabBarController*)vc;
        }
    }
    
    return nil;
}

@end



@implementation UIViewController (RouteProtocol)

+ (nonnull UIViewController<TCMRouteProtocol> *)routeWithParams:(nullable NSDictionary<NSString *, id> *)params{
    return nil;
}
- (void)routePopWithParams:(nullable NSDictionary<NSString *, id> *)params{
    
}

@end


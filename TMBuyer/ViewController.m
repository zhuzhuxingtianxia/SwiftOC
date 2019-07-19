//
//  ViewController.m
//  TMBuyer
//
//  Created by ZZJ on 2019/7/9.
//  Copyright © 2019 Jion. All rights reserved.
//

#import "ViewController.h"
#import <TCMBase/TCMBase.h>
#import "TCMLoginManger.h"
#import "TMBuyer-Swift.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (IBAction)checkLogin:(id)sender {
    
//    [TCMRoute routeWithTarget:@"TCMLoginController" params:@{@"title":@"标题"}];
    
    [TCMRoute routeWithTarget:@"HomeModule.CenterViewController" routeStyle:TCMRoutePresent params:@{@"pp":@"参数"}];
    
    /*
    
    if ([TCMLoginManger loginView:self]) {
        NSLog(@"登陆");
    }else{
        NSLog(@"未登陆");
    }*/
}
- (IBAction)pushAction:(id)sender {
//    [TCMRoute routeWithTarget:@"HomeViewController" params:@{@"title":@"标题"}];
    
//    DetaileController *detaileVC = [[DetaileController alloc] init];
    
}
- (IBAction)changeTabAction:(id)sender {
    [TCMRoute routeWithTarget:@"SettingViewController" routeStyle:TCMRouteTab params:@{}];
}

- (void)routePopWithParams:(NSDictionary<NSString *,id> *)params {
    
    NSLog(@"%@",params);
}

@end

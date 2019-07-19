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

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *showLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}


- (IBAction)pushAction:(id)sender {
    [TCMRoute routeWithTarget:@"HomeViewController" params:@{@"title":@"这就是home的参数"}];
    
}
- (IBAction)pushSwiftAction:(id)sender{
    
    [TCMRoute routeWithTarget:@"HomeModule.SwiftController" routeStyle:TCMRoutePush params:@{@"pp":@"这是传给swift的参数"}];
}

- (IBAction)changeTabAction:(id)sender {
    [TCMRoute routeWithTarget:@"SettingViewController" routeStyle:TCMRouteTab params:@{@"info":@"传值成功"}];
}

- (IBAction)checkLogin:(id)sender {
    
    [TCMRoute routeWithTarget:@"TCMLoginController" routeStyle:TCMRoutePresent params:@{@"title":@"标题"}];
    
    /*
     
     if ([TCMLoginManger loginView:self]) {
     NSLog(@"登陆");
     }else{
     NSLog(@"未登陆");
     }*/
}

#pragma mark -- TCMRouteProtocol

- (void)routePopWithParams:(NSDictionary<NSString *,id> *)params {
    self.showLabel.text = params[@"info"];
    NSLog(@"%@",params);
}

@end

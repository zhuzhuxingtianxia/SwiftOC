//
//  SettingViewController.m
//  TMBuyer
//
//  Created by ZZJ on 2019/7/15.
//  Copyright © 2019 Jion. All rights reserved.
//

#import "SettingViewController.h"
#import "TMBuyer-Swift.h"
#import <TCMBase/TCMBase.h>

@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
}
- (IBAction)centerAction:(id)sender {
     [TCMRoute routeWithTarget:@"HomeModule.CenterViewController" params:@{}];
}

- (IBAction)toXXView:(id)sender {
    
    XXViewController *xx = [XXViewController new];
    xx.title = @"从OC来到swift";
    [self.navigationController pushViewController:xx animated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

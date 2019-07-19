//
//  RunLabelController.m
//  ComponentDemo
//
//  Created by ZZJ on 2019/7/12.
//  Copyright © 2019 Jion. All rights reserved.
//

#import "RunLabelController.h"
#import <TCMComponent.h>

@interface RunLabelController ()
@property (weak, nonatomic) IBOutlet TCMRunLabel *xibLabel;

@end

@implementation RunLabelController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    TCMRunLabel *label = [TCMRunLabel new];
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor redColor];
    label.backgroundColor = [UIColor yellowColor];
    label.text = @"卡起来非常就和死这样子了卡起来非常就和死这样子了...";
    
    label.frame = CGRectMake(10, 80, self.view.frame.size.width-20, 40);
    
    [self.view addSubview:label];
    
    _xibLabel.text = @"卡起来非常就和死这样子了卡起来非常就和死这样子了...";
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

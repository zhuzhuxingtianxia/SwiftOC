//
//  ViewController.m
//  SharePayDemo
//
//  Created by ZZJ on 2019/7/11.
//  Copyright © 2019 Jion. All rights reserved.
//

#import "ViewController.h"
#import <TCMSharePay.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)share1:(id)sender {
    
    SocialShareMessage *message = [SocialShareMessage new];
    message.title = @"标题";
    message.desc = @"分享描述";
    message.shareType = SocialShareTypeText;
    message.platform = SocialSharePlatform_WeChat_Timeline;
    
    [SocialShare sendMessage:message respondBlock:^(SocialShareResp *resp) {
        NSLog(@"%@",resp);
    }];
}

- (IBAction)share2:(id)sender {
}
- (IBAction)payAction:(id)sender {
    
}

@end

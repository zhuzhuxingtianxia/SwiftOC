//
//  ViewController.m
//  BaseDemo
//
//  Created by ZZJ on 2019/7/10.
//  Copyright © 2019 Jion. All rights reserved.
//

#import "ViewController.h"
#import <TCMBase/TCMBase.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    if ([TCMCheck validateMobile:@"1344657"]) {
        NSLog(@"00000");
    }else{
        NSLog(@"1111");
    }
    
}


@end

//
//  ViewController.m
//  ComponentDemo
//
//  Created by ZZJ on 2019/7/10.
//  Copyright © 2019 Jion. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSArray *array;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
#if __has_include(<TCMBase/TCMBase.h>)
    NSLog(@"include");
#else
    NSLog(@"no-include");
#endif
    
    [self setup];
    
}

-(void)setup {
    self.array = @[@"TCMBannerView",@"TabPage效果展示",@"TabPage实例",@"RunLabel跑马灯"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = self.array[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        UIViewController *vc = [NSClassFromString(@"BannerViewController") new];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 1){
        UIViewController *vc = [NSClassFromString(@"TabPageController1") new];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 2){
        UIViewController *vc = [NSClassFromString(@"TabPageExampleController") new];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 3){
        
        UIViewController *vc = [[NSClassFromString(@"RunLabelController") alloc] initWithNibName:@"RunLabelController" bundle:nil];
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

@end

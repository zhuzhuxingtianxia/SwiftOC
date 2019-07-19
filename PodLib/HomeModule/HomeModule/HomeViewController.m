//
//  HomeViewController.m
//  AFNetworking
//
//  Created by ZZJ on 2019/7/12.
//

#import "HomeViewController.h"
#import <TCMBase/TCMBase.h>


@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view from its nib.
    
}
- (IBAction)jumpModuleData:(id)sender {
    
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
    
    [TCMRoute routeWithTarget:@"SettingViewController" routeStyle:TCMRouteTab params:@{}];
}

+ (nonnull UIViewController<TCMRouteProtocol> *)routeWithParams:(id)params {
    HomeViewController *vc = [[HomeViewController alloc] initWithNibName:NSStringFromClass([self class]) bundle:[NSBundle bundleForClass:[self class]]];
    vc.title = params[@"title"];
    return vc;
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

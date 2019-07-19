//
//  TCMLoginController.m
//  AFNetworking
//
//  Created by ZZJ on 2019/7/12.
//

#import "TCMLoginController.h"
#import <TCMBase/TCMBase.h>

NSInteger const TCMAccountSystemPhoneLength = 11;
NSInteger const TCMAccountSystemPasswordLengthMin = 6;
NSInteger const TCMAccountSystemPasswordLengthMax = 12;

@interface TCMLoginController ()<UITextFieldDelegate>
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *userNameField;
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *passwordField;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation TCMLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self buildView];
}

-(void)buildView {
    self.userNameField.delegate = self;
    self.passwordField.delegate = self;
    
    if (@available(iOS 11.0, *)) {
        self.userNameField.textContentType = UITextContentTypeUsername;
        self.passwordField.textContentType = UITextContentTypePassword;
        
    } else if (@available(iOS 12.0, *)) {
        BOOL isSecret = YES;
        self.passwordField.textContentType = isSecret?UITextContentTypeNewPassword:UITextContentTypeOneTimeCode;
        //        self.passwordField.passwordRules = [UITextInputPasswordRules passwordRulesWithDescriptor:@"required: lower; required: upper; allowe: digit; required: [-]; minlength: 6;maxlength: 8;"];
    }
}

#pragma mark -- UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSLog(@"%@",string);
    NSString *sbString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    textField.text = sbString;
    if (textField == self.userNameField) {
        if (textField.text.length >= TCMAccountSystemPhoneLength) {
            textField.text = [textField.text substringToIndex:TCMAccountSystemPhoneLength];
            if ([TCMCheck validateMobile:textField.text]) {
                NSLog(@"手机号");
            }else{
                NSLog(@"无效的手机号");
            }
        }
    }
    
    return NO;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view  endEditing:YES];
}

#pragma mark -- Action
- (IBAction)loginAction:(id)sender {
    
    [TCMRoute routeWithTarget:@"ViewController" routeStyle:TCMRoutePop params:@{@"login":@"成功"}];
    
    [self dismissViewControllerAnimated:YES completion:^{

    }];
}
- (IBAction)jumpOtherModule:(id)sender {
    [TCMRoute routeWithTarget:@"HomeViewController" params:@{}];
   
}


+ (nonnull UIViewController<TCMRouteProtocol> *)routeWithParams:(id)params {
    TCMLoginController *vc = [TCMLoginController new];

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

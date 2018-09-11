//
//  CBForgetPwdVC.m
//  ProApp
//
//  Created by hxbjt on 2018/5/29.
//  Copyright © 2018年 ChenBing. All rights reserved.
//

#import "CBForgetPwdVC.h"
#import "CBLoginLogic.h"

@interface CBForgetPwdVC ()

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
@property (weak, nonatomic) IBOutlet UITextField *checkPwdTextField;
@property (weak, nonatomic) IBOutlet UIButton *codeButton;
@property (weak, nonatomic) IBOutlet UIButton *okButton;

@property (nonatomic, assign) NSInteger authCodeTime;
@property (nonatomic, strong) NSTimer *messsageTimer;

@property (nonatomic, strong) CBLoginLogic *logic;

@end

@implementation CBForgetPwdVC

- (CBLoginLogic *)logic {
    if (!_logic) {
        _logic = [CBLoginLogic new];
    }
    return _logic;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"忘记密码";
    self.authCodeTime = 60;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(actionChangeBtnState) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)actionChangeBtnState {
    if (self.phoneTextField.text.length == 11) {
        self.codeButton.enabled = YES;
        [self.codeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    } else {
        self.codeButton.enabled = NO;
        [self.codeButton setTitleColor:[UIColor colorWithWhite:1 alpha:0.4] forState:UIControlStateDisabled];
    }
    if (self.phoneTextField.text.length == 11 && self.codeTextField.text.length == 6 && self.pwdTextField.text.length > 0 && self.checkPwdTextField.text.length >0) {
        self.okButton.enabled = YES;
        [self.okButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    } else {
        self.okButton.enabled = NO;
        [self.okButton setTitleColor:[UIColor colorWithWhite:1 alpha:0.4] forState:UIControlStateDisabled];
    }
}

// 获取验证码倒计时
- (void)actionTimeCountDown {
    [self.codeButton setTitle:[NSString stringWithFormat:@"%ds", (int)self.authCodeTime] forState:UIControlStateNormal];
    self.codeButton.userInteractionEnabled = NO;
    if (self.authCodeTime <= 0) {
        [self.codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.codeButton.userInteractionEnabled = YES;
        [self.messsageTimer invalidate];
        self.messsageTimer = nil;
        self.authCodeTime = 60;
    }
    self.authCodeTime -= 1;
}


- (IBAction)actionGetCode:(id)sender {
    [self.view endEditing:YES];
    
    self.authCodeTime = 60;
    self.codeButton.userInteractionEnabled = NO;
    [self showLoading];
    @weakify(self);
    [self.logic logicVerCodeWithUserName:self.phoneTextField.text andStatus:@"forgetPassword0" completionBlock:^(id aResponseObject, NSError *error) {
        @strongify(self);
        self.codeButton.userInteractionEnabled = YES;
        [self hideLoading];
        if (error) {
            [MBProgressHUD showAutoMessage:error.domain];
        } else {
            if (self.messsageTimer == nil) {
                self.messsageTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(actionTimeCountDown) userInfo:nil repeats:YES];
            }
        }
    }];
}

- (IBAction)actionOKPwd:(id)sender {
    [self.view endEditing:YES];
    
    [self showLoading];
    @weakify(self);
    [self.logic logicForgetWithUserName:self.phoneTextField.text verCode:self.codeTextField.text password:self.pwdTextField.text repassword:self.checkPwdTextField.text completionBlock:^(id aResponseObject, NSError *error) {
        @strongify(self);
        [self hideLoading];
        if (error) {
            [MBProgressHUD showAutoMessage:error.domain];
        } else {
            [MBProgressHUD showAutoMessage:@"密码重置成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    if (self.messsageTimer) {
        [self.messsageTimer invalidate];
        self.messsageTimer = nil;
    }    
}

@end

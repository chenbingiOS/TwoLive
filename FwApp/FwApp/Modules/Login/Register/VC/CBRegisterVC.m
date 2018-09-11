//
//  CBRegisterVC.m
//  ProApp
//
//  Created by 陈冰 on 2018/5/11.
//  Copyright © 2018年 ChenBing. All rights reserved.
//

#import "CBRegisterVC.h"
#import "UITextField+LeftImageView.h"
#import "CBWebVC.h"
#import "CBTBC.h"
#import "CBLoginLogic.h"

@interface CBRegisterVC ()

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
@property (weak, nonatomic) IBOutlet UIButton *authCodeBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UIButton *agreementBtn;

@property (nonatomic, assign) NSInteger authCodeTime;
@property (nonatomic, strong) NSTimer *messsageTimer;

@property (nonatomic,strong) CBLoginLogic *logic; //逻辑层

@end

@implementation CBRegisterVC

- (CBLoginLogic *)logic {
    if (!_logic) {
        _logic = [CBLoginLogic new];
    }
    return _logic;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(actionChangeBtnState) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupUI {
    [self.phoneTextField leftImageViewImageName:@"login_icon_phone"];
    [self.codeTextField leftImageViewImageName:@"login_icon_verificationcode"];
    [self.pwdTextField leftImageViewImageName:@"login_icon_password"];
}

- (IBAction)actionCode:(id)sender {
    [self.view endEditing:YES];
    
    self.authCodeTime = 60;
    self.authCodeBtn.userInteractionEnabled = NO;
    [self showLoading];
    @weakify(self);
    [self.logic logicVerCodeWithUserName:self.phoneTextField.text andStatus:@"register0" completionBlock:^(id aResponseObject, NSError *error) {
        @strongify(self);
        [self hideLoading];
        self.authCodeBtn.userInteractionEnabled = YES;
        if (error) {
            [MBProgressHUD showAutoMessage:error.domain];
        } else {
            [MBProgressHUD showAutoMessage:@"验证码已发送，请注意查收"];
            if (self.messsageTimer == nil) {
                self.messsageTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(actionTimeCountDown) userInfo:nil repeats:YES];
            }
        }
    }];
}

- (IBAction)actionRegister:(id)sender {
    [self.view endEditing:YES];
    
    if (self.agreementBtn.selected == NO) {
        [MBProgressHUD showAutoMessage:@"请先同意用户协议"];
        return;
    }
    
    [self showLoading];
    [self.logic logicRegisterWithUserName:self.phoneTextField.text andPassword:self.pwdTextField.text verCode:self.codeTextField.text completionBlock:^(id aResponseObject, NSError *error) {
        [self hideLoading];
        if (error) {
            [MBProgressHUD showAutoMessage:error.domain];
        } else {

        }
    }];
}

- (IBAction)actionUserAgreement:(id)sender {
    [self.view endEditing:YES];
    CBWebVC *vc = [CBWebVC new];
    vc.title = @"服务和隐私条款";
//    [vc webViewloadRequestWithURLString:H5_protocol];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)actionUserAgreementCheck:(UIButton *)sender {
    [self.view endEditing:YES];
    sender.selected = !sender.selected;
}

- (IBAction)actionLogin:(id)sender {
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)actoinClose:(id)sender {
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)actionOpenEye:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.pwdTextField.secureTextEntry = !sender.selected;
}

- (void)actionChangeBtnState {
    if (self.phoneTextField.text.length == 11) {
        self.authCodeBtn.enabled = YES;
        [self.authCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    } else {
        self.authCodeBtn.enabled = NO;
        [self.authCodeBtn setTitleColor:[UIColor colorWithWhite:1 alpha:0.4] forState:UIControlStateDisabled];
    }
    if (self.phoneTextField.text.length == 11 && self.codeTextField.text.length == 6 && self.pwdTextField.text.length > 0) {
        self.registerBtn.enabled = YES;
        [self.registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    } else {
        self.registerBtn.enabled = NO;
        [self.registerBtn setTitleColor:[UIColor colorWithWhite:1 alpha:0.4] forState:UIControlStateDisabled];
    }
}

//获取验证码倒计时
- (void)actionTimeCountDown{
    [self.authCodeBtn setTitle:[NSString stringWithFormat:@"%ds", (int)self.authCodeTime] forState:UIControlStateNormal];
    self.authCodeBtn.userInteractionEnabled = NO;
    if (self.authCodeTime <= 0) {
        [self.authCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.authCodeBtn.userInteractionEnabled = YES;
        [self.messsageTimer invalidate];
        self.messsageTimer = nil;
        self.authCodeTime = 60;
    }
    self.authCodeTime -= 1;
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

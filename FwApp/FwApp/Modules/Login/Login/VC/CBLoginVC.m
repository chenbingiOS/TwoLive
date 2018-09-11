//
//  CBLoginVC.m
//  ProApp
//
//  Created by 陈冰 on 2018/5/10.
//  Copyright © 2018年 ChenBing. All rights reserved.
//

// VC
#import "CBLoginVC.h"
#import "CBRegisterVC.h"
#import "CBWebVC.h"
#import "CBTBC.h"
#import "CBForgetPwdVC.h"
// Logic
#import "CBLoginLogic.h"
// User
#import "CBUserProfileVO.h"
#import "CBUserProfileLogic.h"
// Category
#import "UITextField+LeftImageView.h"
// Third
#import <ShareSDKExtension/SSEThirdPartyLoginHelper.h>
#import <ShareSDKExtension/ShareSDK+Extension.h>
//#import <Bugly/Bugly.h>

//渠道ID
#define registerFlag @"11343"

@interface CBLoginVC ()

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *wxBtn;
@property (weak, nonatomic) IBOutlet UIButton *wbBtn;
@property (weak, nonatomic) IBOutlet UIButton *qqBtn;

@property (nonatomic,strong) CBLoginLogic *logic; //逻辑层

@end

@implementation CBLoginVC

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

- (void)setupUI {
    [self.phoneTextField leftImageViewImageName:@"login_icon_phone"];
    [self.pwdTextField leftImageViewImageName:@"login_icon_password"];
    
    if ([ShareSDK isClientInstalled:SSDKPlatformTypeWechat]) {
        self.wxBtn.hidden = NO;
    }
//    if ([ShareSDK isClientInstalled:SSDKPlatformTypeSinaWeibo]) {
//        self.wbBtn.hidden = NO;
//    }
    if ([ShareSDK isClientInstalled:SSDKPlatformTypeQQ]) {
        self.qqBtn.hidden = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionClose:(id)sender {
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)actionOpenEye:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.pwdTextField.secureTextEntry = !sender.selected;
}

- (IBAction)actionForgetPwd:(id)sender {
    [self.view endEditing:YES];
    CBForgetPwdVC *vc = [CBForgetPwdVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)actionRegister:(id)sender {
    [self.view endEditing:YES];
    CBRegisterVC *vc = [CBRegisterVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)actionPolicy:(id)sender {
    [self.view endEditing:YES];
    CBWebVC *vc = [CBWebVC new];
    vc.title = @"服务和隐私条款";
//    [vc webViewloadRequestWithURLString:H5_protocol];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)actionLogin:(id)sender {
    [self.view endEditing:YES];

    [self showLoading];
    @weakify(self);
    [self.logic logicLoginWithUserName:self.phoneTextField.text andPassword:self.pwdTextField.text completionBlock:^(id aResponseObject, NSError *error) {
        @strongify(self);
        [self hideLoading];
        if (error) {
            [MBProgressHUD showAutoMessage:error.domain];
        } else {
            
        }
    }];
}

- (void)actionChangeBtnState {
    if (self.phoneTextField.text.length > 0 && self.pwdTextField.text.length > 0) {
        self.loginBtn.enabled = YES;
        [self.loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    } else {
        self.loginBtn.enabled = NO;
        [self.loginBtn setTitleColor:[UIColor colorWithWhite:1 alpha:0.4] forState:UIControlStateDisabled];
    }
}

- (IBAction)actionThirdLogin:(UIButton *)sender {
    [self.view endEditing:YES];
    if (sender.tag == 11) {
        [self thirdLoginByPlatforms:SSDKPlatformTypeWechat];
    } else if (sender.tag == 22) {
        [self thirdLoginByPlatforms:SSDKPlatformTypeSinaWeibo];
    } else if (sender.tag == 33) {
        [self thirdLoginByPlatforms:SSDKPlatformTypeQQ];
    }
}

- (void)thirdLoginByPlatforms:(SSDKPlatformType)platform{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [SSEThirdPartyLoginHelper loginByPlatform:platform onUserSync:^(SSDKUser *user, SSEUserAssociateHandler associateHandler) {
        [self requestLogin:user loginType:platform];
    } onLoginResult:^(SSDKResponseState state, SSEBaseUser *user, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showAutoMessage:@"登录失败"];
    }];
}

- (void)requestLogin:(SSDKUser *)user loginType:(SSDKPlatformType)loginType {
    NSDictionary *param = [self paramWithUser:user loginType:loginType];
    @weakify(self);
    [self.logic logicThirdLoginWithParam:param completionBlock:^(id aResponseObject, NSError *error) {
        @strongify(self);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (error) {
            [MBProgressHUD showAutoMessage:error.domain];
        } else {
            
        }
    }];
}

- (NSMutableDictionary *)paramWithUser:(SSDKUser *)user loginType:(SSDKPlatformType)loginType {
    
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
    NSString *logAuthTypeType = nil;
    
    switch (loginType) {
        case SSDKPlatformTypeWechat: logAuthTypeType = @"Wechat"; break;
        case SSDKPlatformTypeQQ: logAuthTypeType = @"QQ"; break;
        case SSDKPlatformTypeSinaWeibo: logAuthTypeType = @"SinaWeibo"; break;
        default: break;
    }
    
    switch (user.gender) {
        case SSDKGenderMale: [paramDict setObject:@"1" forKey:@"sex"]; break;
        case SSDKGenderFemale: [paramDict setObject:@"2" forKey:@"sex"]; break;
        case SSDKGenderUnknown: [paramDict setObject:@"0" forKey:@"sex"]; break;
        default: break;
    }
    
    //生日
    //    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //    NSString *dateStr = [dateFormatter stringFromDate:user.birthday];
    
    [paramDict setObject:user.uid ? : @"" forKey:@"openid"];                                       //openid
    [paramDict setObject:logAuthTypeType ? : @"" forKey:@"from"];                                  //authorType
    [paramDict setObject:[user.rawData objectForKey:@"unionid"] ? : @"" forKey:@"unionid"];        //authUnionid
    //    [paramDict setObject:[user.rawData objectForKey:@"age"] ? : @"" forKey:@"userAge"];                //userAge
    [paramDict setObject:user.icon ? : @"" forKey:@"head_img"];                                      //userAvatar
    //    [paramDict setObject:dateStr ? : @"" forKey:@"userBirthday"];                                      //userBirthday
    //    [paramDict setObject:[user.rawData objectForKey:@"city"]?:@"" forKey:@"userCity"];              //userCity
    [paramDict setObject:user.nickname ? : @"" forKey:@"name"];                                //userNickname
    //    [paramDict setObject:[user.rawData objectForKey:@"province"]?:@"" forKey:@"userProvince"];      //userProvince
    //    [paramDict setObject:user.verifyReason?:@"" forKey:@"verifiedReason"];                          //verifiedReason
    [paramDict setObject:user.credential.token ? : @"" forKey:@"access_token"];                          //access_token
    [paramDict setObject:user.credential.expired ? : @"" forKey:@"expires_date"];                          //expires_date
    
    NSLog(@"第三方登录获取信息 %@", [paramDict modelToJSONString]);
    
    return paramDict;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

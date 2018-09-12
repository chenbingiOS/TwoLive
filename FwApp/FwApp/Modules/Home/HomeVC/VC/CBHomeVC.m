//
//  CBHomeVC.m
//  FwApp
//
//  Created by hxbjt on 2018/9/7.
//  Copyright © 2018年 fengwo. All rights reserved.
//

#import "CBHomeVC.h"
#import "CBHomeVCUI.h"

@interface CBHomeVC ()

@property (nonatomic, strong) CBHomeVCUI *ownerVCUI;

@end

@implementation CBHomeVC

- (CBHomeVCUI *)ownerVCUI {
    if (!_ownerVCUI) {
        _ownerVCUI = [CBHomeVCUI new];
        _ownerVCUI.ownerVC = self;
    }
    return _ownerVCUI;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.ownerVCUI _setup_UI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

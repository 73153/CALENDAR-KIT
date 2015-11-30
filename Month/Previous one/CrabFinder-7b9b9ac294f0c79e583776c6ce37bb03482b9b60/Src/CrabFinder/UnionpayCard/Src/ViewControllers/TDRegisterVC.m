//
//  TDRegisterVC.m
//  UnionpayCard
//
//  Created by Dong Yiming on 2/23/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDRegisterVC.h"

@interface TDRegisterVC () {
    UIImageView     *_ivProgress;
    UIImageView     *_ivBgInput;
    UITextField     *_tfInput;
    UIButton        *_btnGetCode;
}

@end

@implementation TDRegisterVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"注册";
    
    [self createViews];
    [self layoutViews];
}

-(void)createViews {
    _ivProgress = [UIImageView new];
    _ivProgress.image = [UIImage imageNamed:@"register_step1_banner"];
    [self.view addSubview:_ivProgress];
    
    _ivBgInput = [UIImageView new];
    _ivBgInput.image = [TDImageLibrary sharedInstance].blank;
    [self.view addSubview:_ivBgInput];
    
    _tfInput = [UITextField new];
    _tfInput.placeholder = @"请输入您的手机号";
    _tfInput.font = [TDFontLibrary sharedInstance].fontNormal;
    _tfInput.clearButtonMode = UITextFieldViewModeWhileEditing;
    _tfInput.keyboardType = UIKeyboardTypePhonePad;
    [self.view addSubview:_tfInput];
    
    _btnGetCode = [UIButton new];
    [_btnGetCode setBackgroundImage:[TDImageLibrary sharedInstance].btnBg forState:UIControlStateNormal];
    [_btnGetCode setTitle:@"获取验证码" forState:UIControlStateNormal];
    _btnGetCode.titleLabel.font = [TDFontLibrary sharedInstance].fontTitleBold;
    [self.view addSubview:_btnGetCode];
}

-(void)layoutViews {
    [_ivProgress alignTopEdgeWithView:self.view predicate:nil];
    [_ivProgress alignCenterXWithView:self.view predicate:nil];
    
    [_ivBgInput constrainTopSpaceToView:_ivProgress predicate:@"20"];
    [_ivBgInput alignCenterXWithView:self.view predicate:nil];
    
    [_tfInput alignLeading:@"20" trailing:@"-20" toView:_ivBgInput];
    [_tfInput alignCenterYWithView:_ivBgInput predicate:nil];
    
    [_btnGetCode constrainWidthToView:_ivBgInput predicate:nil];
    [_btnGetCode alignCenterXWithView:self.view predicate:nil];
    [_btnGetCode constrainTopSpaceToView:_ivBgInput predicate:@"20"];
}



@end

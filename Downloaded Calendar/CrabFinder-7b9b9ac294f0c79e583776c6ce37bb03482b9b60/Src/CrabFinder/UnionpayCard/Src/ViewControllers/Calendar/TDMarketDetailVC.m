//
//  TDMarketDetailVC.m
//  UnionpayCard
//
//  Created by Dong Yiming on 3/24/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDMarketDetailVC.h"
#import "TDVendorsVC.h"

@interface TDMarketDetailVC ()

@property (weak, nonatomic) IBOutlet UIImageView *ivPhoto;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UIButton *btnPhone;
@property (weak, nonatomic) IBOutlet UIButton *btnLocation;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UILabel *lblBio;
@property (weak, nonatomic) IBOutlet UIScrollView *svPictures;
@property (strong, nonatomic)  UIButton *btnVendors;

@end

@implementation TDMarketDetailVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Farmer's Market";
    
    _btnVendors = [UIButton new];
    [self.view addSubview:_btnVendors];
    [_btnVendors alignCenterXWithView:self.view predicate:nil];
    [_btnVendors alignBottomEdgeWithView:self.view predicate:@"-50"];
    [_btnVendors constrainWidth:@"200"];
    
    _btnVendors.titleLabel.font = [TDFontLibrary sharedInstance].fontNormal;
    [_btnVendors setBackgroundImage:[TDImageLibrary sharedInstance].btnBg forState:UIControlStateNormal];
    [_btnVendors setTitle:@"View Vendors" forState:UIControlStateNormal];
    [_btnVendors addTarget:self action:@selector(goVendorsAction:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)goVendorsAction:(id)sender {
    TDVendorsVC *vc = [TDVendorsVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

@end

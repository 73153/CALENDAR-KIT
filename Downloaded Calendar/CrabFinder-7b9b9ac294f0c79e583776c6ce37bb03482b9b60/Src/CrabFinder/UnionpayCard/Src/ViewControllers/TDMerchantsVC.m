//
//  TDMerchantsVC.m
//  UnionpayCard
//
//  Created by Dong Yiming on 2/18/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDMerchantsVC.h"
#import "TDNotificationsVC.h"
#import "TDDealsVC.h"
#import "TDSeasonalCategoriesVC.h"

@interface TDMerchantsVC () {
    UIButton        *_btnNotification;
    UIButton        *_btnDeals;
    UIButton        *_btnItems;
}

@end

@implementation TDMerchantsVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Deals";
    
    [self installSearchToNavibar];
    
    [self setupViews];
}

-(void)setupViews {
    //
    _btnNotification = [UIButton new];
    _btnNotification.backgroundColor = [FDColor sharedInstance].caribbeanGreen;
    [_btnNotification setTitle:@"Notifications" forState:UIControlStateNormal];
    _btnNotification.titleLabel.font = [TDFontLibrary sharedInstance].fontTitleBold;
    [_btnNotification setTitleColor:[FDColor sharedInstance].white forState:UIControlStateNormal];
    [_btnNotification setTitleColor:[FDColor sharedInstance].magicMint forState:UIControlStateHighlighted];
    [_btnNotification addTarget:self action:@selector(gotoNotofications:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnNotification];
    
    _btnNotification.translatesAutoresizingMaskIntoConstraints = NO;
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"|-30-[_btnNotification]-30-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_btnNotification)];
    [self.view addConstraints:constraints];
    
    //
    _btnDeals = [UIButton new];
    _btnDeals.backgroundColor = [FDColor sharedInstance].midnightBlue;
    [_btnDeals setTitle:@"Deals" forState:UIControlStateNormal];
    _btnDeals.titleLabel.font = [TDFontLibrary sharedInstance].fontTitleBold;
    [_btnDeals setTitleColor:[FDColor sharedInstance].white forState:UIControlStateNormal];
    [_btnDeals setTitleColor:[FDColor sharedInstance].lightGray forState:UIControlStateHighlighted];
    [_btnDeals addTarget:self action:@selector(gotoDeals:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnDeals];
    
    _btnDeals.translatesAutoresizingMaskIntoConstraints = NO;
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"|-30-[_btnDeals]-30-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_btnDeals)];
    [self.view addConstraints:constraints];
    
    //
    _btnItems = [UIButton new];
    _btnItems.backgroundColor = [FDColor sharedInstance].blueSapphire;
    [_btnItems setTitle:@"Seasonal Items" forState:UIControlStateNormal];
    _btnItems.titleLabel.font = [TDFontLibrary sharedInstance].fontTitleBold;
    [_btnItems setTitleColor:[FDColor sharedInstance].white forState:UIControlStateNormal];
    [_btnItems setTitleColor:[FDColor sharedInstance].desertSand forState:UIControlStateHighlighted];
    [_btnItems addTarget:self action:@selector(gotoItems:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnItems];
    
    _btnItems.translatesAutoresizingMaskIntoConstraints = NO;
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"|-30-[_btnItems]-30-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_btnItems)];
    [self.view addConstraints:constraints];
    
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-40-[_btnNotification(60)]-[_btnDeals(60)]-[_btnItems(60)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_btnNotification, _btnDeals, _btnItems)];
    [self.view addConstraints:constraints];
}

#pragma mark - actions
-(void)gotoItems:(id)sender {
    TDSeasonalCategoriesVC *vc = [TDSeasonalCategoriesVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)gotoDeals:(id)sender {
    TDDealsVC *vc = [TDDealsVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)gotoNotofications:(id)sender {
    TDNotificationsVC *vc = [TDNotificationsVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

@end

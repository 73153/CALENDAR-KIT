//
//  TDImageVC.m
//  UnionpayCard
//
//  Created by Dong Yiming on 3/25/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDImageVC.h"

@interface TDImageVC () {
    NSURL   *_imageURL;
    
    UIImageView *_iv;
}

@end

@implementation TDImageVC

+(TDImageVC *)newWithURL:(NSURL*)imageURL {
    TDImageVC *instance = [TDImageVC new];
    instance->_imageURL = imageURL;
    return instance;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Photo";
    
    UIBarButtonItem *btnDismiss = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismissAction:)];
    self.navigationItem.leftBarButtonItem = btnDismiss;
    self.navigationItem.rightBarButtonItem = nil;
    
    
    _iv = [UIImageView new];
    _iv.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:_iv];
    [_iv alignToView:self.view];
    
    [_iv setImageWithURL:_imageURL placeholderImage:nil];
}

@end

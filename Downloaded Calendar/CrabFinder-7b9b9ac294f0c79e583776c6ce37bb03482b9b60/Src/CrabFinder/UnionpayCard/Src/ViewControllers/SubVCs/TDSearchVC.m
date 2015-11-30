//
//  TDSearchVC.m
//  UnionpayCard
//
//  Created by Dong Yiming on 3/25/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDSearchVC.h"

@interface TDSearchVC ()

@end

@implementation TDSearchVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Search";
    
    UIBarButtonItem *btnDismiss = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismissAction:)];
    self.navigationItem.leftBarButtonItem = btnDismiss;
    self.navigationItem.rightBarButtonItem = nil;
    
    [self installUnderConstructionPic];
}

@end

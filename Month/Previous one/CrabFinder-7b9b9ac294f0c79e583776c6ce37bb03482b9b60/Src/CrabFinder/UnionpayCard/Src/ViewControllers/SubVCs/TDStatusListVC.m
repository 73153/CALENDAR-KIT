//
//  TDStatusListVC.m
//  UnionpayCard
//
//  Created by Dong Yiming on 3/25/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDStatusListVC.h"

@interface TDStatusListVC ()

@end

@implementation TDStatusListVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"All Status";
    
    [self installUnderConstructionPic];
}

@end

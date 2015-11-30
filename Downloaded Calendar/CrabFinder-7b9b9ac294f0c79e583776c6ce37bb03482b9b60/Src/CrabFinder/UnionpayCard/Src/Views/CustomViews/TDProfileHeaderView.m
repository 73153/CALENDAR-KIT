//
//  TDProfileHeaderView.m
//  UnionpayCard
//
//  Created by Dong Yiming on 3/25/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDProfileHeaderView.h"

@implementation TDProfileHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [FDColor sharedInstance].silver;
        
        UIView  *seperator = [UIView new];
        seperator.backgroundColor = [FDColor sharedInstance].lightGray;
        [self addSubview:seperator];
        [seperator constrainHeight:@"0.5"];
        [seperator alignLeading:@"0" trailing:@"0" toView:self];
        [seperator alignTopEdgeWithView:seperator predicate:@"0"];
        
        _lblTitle = [UILabel new];
        _lblTitle.font = [TDFontLibrary sharedInstance].fontNormalBold;
        [self addSubview:_lblTitle];
        
        [_lblTitle alignLeadingEdgeWithView:self predicate:@"20"];
        [_lblTitle alignCenterYWithView:self predicate:nil];
        
        _btnMore = [UIButton new];
        _btnMore.titleLabel.font = [TDFontLibrary sharedInstance].fontNormal;
        [_btnMore setTitleColor:[FDColor sharedInstance].caribbeanGreen forState:UIControlStateNormal];
        [_btnMore setTitle:@"More" forState:UIControlStateNormal];
        [self addSubview:_btnMore];
        
        [_btnMore alignTrailingEdgeWithView:self predicate:@"-20"];
        [_btnMore alignCenterYWithView:self predicate:nil];
        
    }
    return self;
}

+(CGFloat)viewHeight {
    return 40.f;
}

@end

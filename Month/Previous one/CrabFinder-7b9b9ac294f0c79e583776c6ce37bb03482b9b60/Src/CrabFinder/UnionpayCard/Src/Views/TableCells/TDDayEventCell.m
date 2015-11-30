//
//  TDDayEventCell.m
//  UnionpayCard
//
//  Created by Dong Yiming on 3/24/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDDayEventCell.h"

@implementation TDDayEventCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initViews];
        [self setupConstraints];
    }
    return self;
}

-(void)initViews {
    _lblTitle = [UILabel new];
    _lblTitle.font = [TDFontLibrary sharedInstance].fontNormalBold;
    _lblTitle.text = @"Kirk Reviewed Spock";
    [self.contentView addSubview:_lblTitle];
    
    _lblMessage = [UILabel new];
    _lblMessage.font = [TDFontLibrary sharedInstance].fontNormal;
    _lblMessage.numberOfLines = 3;
    [self.contentView addSubview:_lblMessage];
    
    _viewRating = [TDUtil ratingViewEnabled:NO rating:3];
    [self.contentView addSubview:_viewRating];
}

-(void)setupConstraints {
    
    [_lblTitle alignTopEdgeWithView:self.contentView predicate:@"10"];
    [_lblTitle alignLeadingEdgeWithView:self.contentView predicate:@"20"];
    [_lblTitle alignTrailingEdgeWithView:self.contentView predicate:@"-10"];
    
    [_viewRating constrainTopSpaceToView:_lblTitle predicate:@"5"];
    [_viewRating alignLeadingEdgeWithView:_lblTitle predicate:nil];
    [_viewRating constrainWidth:@"100" height:@"20"];
    
    [_lblMessage constrainTopSpaceToView:_viewRating predicate:@"5"];
    [_lblMessage alignLeading:@"0" trailing:@"0" toView:_lblTitle];
}

+(float)cellHeight {
    return 75;
}

@end

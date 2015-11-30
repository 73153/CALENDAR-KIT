//
//  TDReviewCell.m
//  UnionpayCard
//
//  Created by Dong Yiming on 3/17/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDReviewCell.h"

@implementation TDReviewCell

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
    _ivPhoto = [UIImageView new];
    _ivPhoto.image = SharedImage.avatar;
    [_ivPhoto applyEffectRoundRectSilverBorder];
    [self.contentView addSubview:_ivPhoto];
    
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
    [_ivPhoto constrainWidth:@"40" height:@"40"];
    [_ivPhoto alignTopEdgeWithView:self.contentView predicate:@"10"];
    [_ivPhoto alignLeadingEdgeWithView:self.contentView predicate:@"10"];
    
    [_lblTitle alignTopEdgeWithView:_ivPhoto predicate:nil];
    [_lblTitle constrainLeadingSpaceToView:_ivPhoto predicate:@"10"];
    [_lblTitle alignTrailingEdgeWithView:self.contentView predicate:@"-10"];
    
    [_viewRating constrainTopSpaceToView:_lblTitle predicate:@"5"];
    [_viewRating alignLeadingEdgeWithView:_lblTitle predicate:nil];
    [_viewRating constrainWidth:@"100" height:@"20"];
    
    [_lblMessage constrainTopSpaceToView:_viewRating predicate:@"5"];
    [_lblMessage alignLeading:@"0" trailing:@"0" toView:_lblTitle];
}

+(float)cellHeight {
    return 105;
}

@end

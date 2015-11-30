//
//  TDCommentCell.m
//  UnionpayCard
//
//  Created by Dong Yiming on 3/19/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDCommentCell.h"

@implementation TDCommentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _lblTitle = [UILabel new];
        _lblTitle.font = [TDFontLibrary sharedInstance].fontNormalBold;
        [self.contentView addSubview:_lblTitle];
        
        _lblMessage = [UILabel new];
        _lblMessage.numberOfLines = 3;
        _lblMessage.font = [TDFontLibrary sharedInstance].fontNormal;
        [self.contentView addSubview:_lblMessage];
        
        _ivLogo = [UIImageView new];
        _ivLogo.image = SharedImage.avatar;
        [self.contentView addSubview:_ivLogo];
        
        [self setupConstraints];
    }
    return self;
}

-(void)setupConstraints {
    self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    [_ivLogo alignTop:@"10" leading:@"10" toView:self.contentView];
    [_ivLogo constrainWidth:@"40" height:@"40"];
    
    [_lblTitle alignTopEdgeWithView:self.contentView predicate:@"10"];
    [_lblTitle constrainLeadingSpaceToView:_ivLogo predicate:@"10"];
    
    [_lblMessage constrainTopSpaceToView:_lblTitle predicate:@"2"];
    [_lblMessage alignLeadingEdgeWithView:_lblTitle predicate:nil];
    [_lblMessage alignTrailingEdgeWithView:_lblTitle predicate:nil];
    
}

+(CGFloat)cellHeight {
    return 90;
}

-(void)layoutSubviews {
    CGRect bounds = self.bounds;
    
    _lblMessage.preferredMaxLayoutWidth = bounds.size.width - (65 + 10);
    
    [super layoutSubviews];
}

@end

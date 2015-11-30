//
//  TDNewsfeedCell.m
//  UnionpayCard
//
//  Created by Dong Yiming on 3/4/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDStatusFeedCell.h"

//////

//////


@interface TDStatusFeedCell () {
    NSMutableArray      *_pictures;
    UIView              *_imageContainerView;
}

@end

@implementation TDStatusFeedCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self createViews];
        [self setupConstraints];
    }
    return self;
}

-(void)createViews {

    _ivPhoto = [UIImageView new];
    _ivPhoto.image = [TDImageLibrary sharedInstance].avatar;
    [self.contentView addSubview:_ivPhoto];
    [_ivPhoto applyEffectRoundRectSilverBorder];
    
    _lblName = [UILabel new];
    _lblName.font = [TDFontLibrary sharedInstance].fontNormalBold;
    [self.contentView addSubview:_lblName];
    
    _lblTitle = [UILabel new];
    _lblTitle.font = [TDFontLibrary sharedInstance].fontNormal;
    _lblTitle.numberOfLines = 0;
    [self.contentView addSubview:_lblTitle];
    
    _imageContainerView = [UIView new];
    [self.contentView addSubview:_imageContainerView];
    
    int maxPicCount = 4;
    _pictures = [NSMutableArray arrayWithCapacity:maxPicCount];
    for (int i = 0; i < maxPicCount; i++) {
        UIImageView *iv = [UIImageView new];
        iv.image = [TDImageLibrary sharedInstance].farmersMarket;
        [_imageContainerView addSubview:iv];
        
        [_pictures addObject:iv];
    }
}

-(void)setupConstraints {
    self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    _ivPhoto.translatesAutoresizingMaskIntoConstraints = NO;
    _lblTitle.translatesAutoresizingMaskIntoConstraints = NO;
    _lblName.translatesAutoresizingMaskIntoConstraints = NO;
    _imageContainerView.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:_ivPhoto attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:40];
    [self.contentView addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:_ivPhoto attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:40];
    [self.contentView addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:_ivPhoto attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeading multiplier:1 constant:10];
    [self.contentView addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:_ivPhoto attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeading multiplier:1 constant:10];
    [self.contentView addConstraint:constraint];
    
    //
    constraint = [NSLayoutConstraint constraintWithItem:_lblName attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeading multiplier:1 constant:60];
    [self.contentView addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:_lblName attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTrailing multiplier:1 constant:-10];
    [self.contentView addConstraint:constraint];
    
    //
    constraint = [NSLayoutConstraint constraintWithItem:_lblTitle attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeading multiplier:1 constant:60];
    [self.contentView addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:_lblTitle attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTrailing multiplier:1 constant:-10];
    [self.contentView addConstraint:constraint];
    
    //
    constraint = [NSLayoutConstraint constraintWithItem:_imageContainerView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTrailing multiplier:1 constant:-10];
    [self.contentView addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:_imageContainerView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:_lblTitle attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
    [self.contentView addConstraint:constraint];
    
    NSArray *verticalConstriants = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[_lblName]-3-[_lblTitle]-[_imageContainerView(40@1000)]-5-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_lblTitle, _imageContainerView, _lblName)];
    [self.contentView addConstraints:verticalConstriants];
    
    //
    for (UIImageView *iv in _pictures) {
        [iv constrainWidth:@"40"];
        [iv alignTop:@"0" bottom:@"0" toView:_imageContainerView];
    }

    [(_pictures.firstObject) alignLeadingEdgeWithView:_imageContainerView predicate:@"10"];
    [UIView spaceOutViewsHorizontally:_pictures predicate:@"10"];
}

- (void)layoutSubviews
{
    CGRect bounds = self.bounds;
    _lblName.preferredMaxLayoutWidth = bounds.size.width - (60 + 10);
    _lblTitle.preferredMaxLayoutWidth = bounds.size.width - (60 + 10);
    
    [super layoutSubviews];
}

@end

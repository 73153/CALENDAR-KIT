//
//  TDNotificationCell.m
//  UnionpayCard
//
//  Created by Dong Yiming on 3/12/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDNotificationCell.h"

@implementation TDNotificationCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createViews];
        [self setupConstraints];
    }
    return self;
}

- (void)layoutSubviews
{
    CGRect bounds = self.bounds;
    //_lblTitle.preferredMaxLayoutWidth = bounds.size.width - (60 + 10);
    _lblDescription.preferredMaxLayoutWidth = bounds.size.width - (60 + 10);
    
    [super layoutSubviews];
}

-(void)createViews {
    self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    
    _ivPhoto = [UIImageView new];
    _ivPhoto.image = [TDImageLibrary sharedInstance].avatar;
    [self.contentView addSubview:_ivPhoto];
    [_ivPhoto applyEffectBorder];
    
    _lblTitle = [UILabel new];
    _lblTitle.font = [TDFontLibrary sharedInstance].fontTitleBold;
    _lblTitle.numberOfLines = 1;
    [self.contentView addSubview:_lblTitle];
    
    _lblDescription = [UILabel new];
    _lblDescription.font = [TDFontLibrary sharedInstance].fontNormal;
    _lblDescription.numberOfLines = 0;
    [self.contentView addSubview:_lblDescription];
}

-(void)setupConstraints {
    _ivPhoto.translatesAutoresizingMaskIntoConstraints = NO;
    _lblTitle.translatesAutoresizingMaskIntoConstraints = NO;
    _lblDescription.translatesAutoresizingMaskIntoConstraints = NO;
    
    [_lblTitle setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [_lblDescription setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:_ivPhoto attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:40];
    [self.contentView addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:_ivPhoto attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:45];
    [self.contentView addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:_ivPhoto attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeading multiplier:1 constant:10];
    [self.contentView addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:_ivPhoto attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1 constant:10];
    [self.contentView addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:_ivPhoto attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationLessThanOrEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:-10];
    constraint.priority = UILayoutPriorityDefaultHigh;
    [self.contentView addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:_lblDescription attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeading multiplier:1 constant:60];
    [self.contentView addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:_lblDescription attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTrailing multiplier:1 constant:-10];
    [self.contentView addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:_lblTitle attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeading multiplier:1 constant:60];
    [self.contentView addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:_lblTitle attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTrailing multiplier:1 constant:-10];
    [self.contentView addConstraint:constraint];
    
    NSArray *verticalConstriants = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[_lblTitle]-3-[_lblDescription]-(>=5)-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_lblTitle, _lblDescription)];
    [self.contentView addConstraints:verticalConstriants];
}

@end

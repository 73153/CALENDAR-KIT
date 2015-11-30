//
//  TDSettingCell.m
//  UnionpayCard
//
//  Created by Dong Yiming on 2/23/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDSettingCell.h"

#define MY_HEIGHT   (45)

@interface TDSettingCell () {
    UIImageView     *_ivBg;
    UIView          *_seperatorView;
    UIImageView     *_ivArrow;
    UIView          *_highlightCoverView;
    
    UILabel         *_lblTitle;
}

@end

@implementation TDSettingCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createViews];
        [self layoutViews];
        
        [self setStyle:kTDCellStyleRound];
    }
    return self;
}

-(void)createViews {
    _ivBg = [UIImageView new];
    [self.contentView addSubview:_ivBg];
    
    _seperatorView = [UIView new];
    _seperatorView.backgroundColor = [FDColor sharedInstance].silver;
    [self.contentView addSubview:_seperatorView];
    
    _ivArrow = [UIImageView new];
    _ivArrow.image = [TDImageLibrary sharedInstance].cellRightArrow;
    [self.contentView addSubview:_ivArrow];
    
    _highlightCoverView = [UIView new];
    float grayValue = (0XEE/255.f);
    _highlightCoverView.backgroundColor = [UIColor colorWithRed:grayValue green:grayValue blue:grayValue alpha:.5f];
    [self.contentView addSubview:_highlightCoverView];
    _highlightCoverView.hidden = YES;
    
    _lblTitle = [UILabel new];
    _lblTitle.textColor = [FDColor sharedInstance].gray;
    _lblTitle.font = [TDFontLibrary sharedInstance].fontTitle;
    [self.contentView addSubview:_lblTitle];
}

-(void)layoutViews {
    
    [_ivBg constrainHeightToView:self.contentView predicate:nil];
    [_ivBg alignTopEdgeWithView:self.contentView predicate:nil];
    [_ivBg alignLeading:@"20" trailing:@"-20" toView:self];
    
    [_seperatorView constrainHeight:@"1"];
    [_seperatorView alignLeading:@"20" trailing:@"-20" toView:self];
    [_seperatorView alignBottomEdgeWithView:self predicate:nil];
    
    [_ivArrow alignCenterYWithView:self.contentView predicate:nil];
    [_ivArrow alignTrailingEdgeWithView:self.contentView predicate:@"-40"];
    
    [_highlightCoverView alignToView:_ivBg];
    
    [_lblTitle alignCenterYWithView:self.contentView predicate:nil];
    [_lblTitle alignLeadingEdgeWithView:_ivBg predicate:@"10"];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    _highlightCoverView.hidden = !highlighted;
}

-(void)layoutSubviews {
    [super layoutSubviews];
}

#pragma mark - style

-(void)setStyle:(ETDCellStyle)aStyle {
    switch (aStyle) {
        case kTDCellStyleTop:
            _ivBg.image = [TDImageLibrary sharedInstance].cellGroupTop;
            _seperatorView.hidden = NO;
            break;

        case kTDCellStyleMiddle:
            _ivBg.image = [TDImageLibrary sharedInstance].cellGroupMiddle;
            _seperatorView.hidden = NO;
            break;
            
        case kTDCellStyleBottom:
            _ivBg.image = [TDImageLibrary sharedInstance].cellGroupBottom;
            _seperatorView.hidden = YES;
            break;
            
        case kTDCellStyleRound:
            _ivBg.image = [TDImageLibrary sharedInstance].cellGroupRound;
            _seperatorView.hidden = YES;
            break;
            
        default:
            break;
    }
}

+(ETDCellStyle)cellStyleWithIndexPath:(NSIndexPath *)aIndexPath tableView:(UITableView *)aTableView tableViewDataSource:(id<UITableViewDataSource>)aTableViewDataSource {
    
    int section = aIndexPath.section;
    int row = aIndexPath.row;
    
    int count = [aTableViewDataSource tableView:aTableView numberOfRowsInSection:section];
    if (count > 1) {
        if (row == 0) {
            return kTDCellStyleTop;
        } else if (row == count - 1) {
            return kTDCellStyleBottom;
        } else {
            return kTDCellStyleMiddle;
        }
    }
    
    return kTDCellStyleRound;
}

+(float)HEIGHT {
    return MY_HEIGHT;
}

@end

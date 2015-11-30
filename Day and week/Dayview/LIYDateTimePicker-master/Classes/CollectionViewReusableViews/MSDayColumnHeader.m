//
//  MSDayColumnHeader.m
//  Example
//
//  Created by Eric Horacek on 2/26/13.
//  Copyright (c) 2013 Monospace Ltd. All rights reserved.
//

#import "MSDayColumnHeader.h"
#import "Masonry.h"
#import "UIColor+ProjectColors.h"

@interface MSDayColumnHeader ()

@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UIView *titleBackground;
@property (nonatomic, strong) UIView *allDayView;
@property (nonatomic, strong) UILabel *allDayLabel;

@end

@implementation MSDayColumnHeader

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor dayColumnHeaderBackgroundColor];
        self.title = [UILabel new];
        self.title.backgroundColor = [UIColor dayColumnHeaderTitleBackgroundColor];
        self.title.font = [UIFont boldSystemFontOfSize:14.0];
        [self addSubview:self.title];
        
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(@(kLIYAllDayHeight));
        }];
        
        self.allDayView = [UIView new];
        [self addSubview:self.allDayView];
        self.allDayView.backgroundColor = [UIColor dayColumnHeaderAllDayBackgroundColor];
        self.allDayView.clipsToBounds = YES;
        [self.allDayView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self);
            make.height.equalTo(@(kLIYAllDayHeight));
            make.leading.equalTo(@0);
            make.trailing.equalTo(@0);
        }];
        
        self.allDayLabel = [UILabel new];
        [self.allDayView addSubview:self.allDayLabel];
        self.allDayLabel.text = @"all-day";
        [self.allDayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.allDayView);
            make.left.equalTo(@10);
        }];
        self.allDayLabel.font = [UIFont systemFontOfSize:10.0];
        
        self.allDayEventsLabel = [UILabel new];
        self.allDayEventsLabel.textColor = [UIColor dayColumnHeaderAllDayEventTextColor];
        [self.allDayView addSubview:self.allDayEventsLabel];
        [self.allDayEventsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.allDayView);
            make.leading.equalTo(self.allDayLabel.mas_trailing).with.offset(15);
        }];
        self.allDayEventsLabel.font = [UIFont boldSystemFontOfSize:10.0];
        
        UIView *bottomBorder = [[UIView alloc] initWithFrame:CGRectMake(0.0f, self.frame.size.height, self.frame.size.width, 1.0f)];
        bottomBorder.backgroundColor = [UIColor dayColumnHeaderBottomBorderColor];
        [self addSubview:bottomBorder];
    }
    return self;
}

- (void)setDay:(NSDate *)day
{
    _day = day;
    
    static NSDateFormatter *dateFormatter;
    if (!dateFormatter) {
        dateFormatter = [NSDateFormatter new];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            dateFormatter.dateFormat = @"EEE MMM d";
            //TODO: Check
        }
        else
        {
            dateFormatter.dateStyle = NSDateFormatterFullStyle;
        }
    }
    
    if (!self.dayTitlePrefix){
        self.title.text = [dateFormatter stringFromDate:day];
    }else{
        self.title.text = [NSString stringWithFormat:@"%@ %@", self.dayTitlePrefix, [dateFormatter stringFromDate:day]];
    }

    [self setNeedsLayout];
}

- (void)setShowAllDaySection:(BOOL)showAllDaySection {
    _showAllDaySection = showAllDaySection;
    
    if (showAllDaySection) {
        [self.allDayView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(kLIYAllDayHeight));
        }];
    } else {
        [self.allDayView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0);
        }];
    }
}

@end

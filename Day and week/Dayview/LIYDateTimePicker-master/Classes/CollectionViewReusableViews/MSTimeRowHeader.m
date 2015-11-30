//
//  MSTimeRowHeader.m
//  Example
//
//  Created by Eric Horacek on 2/26/13.
//  Copyright (c) 2013 Monospace Ltd. All rights reserved.
//

#import "MSTimeRowHeader.h"
#import "Masonry.h"
#import "UIColor+ProjectColors.h"

@implementation MSTimeRowHeader

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor timeRowHeaderBackgroundColor];
        self.title = [UILabel new];
        self.title.backgroundColor = [UIColor timeRowHeaderTitleBackgroundColor];
        self.title.font = [UIFont systemFontOfSize:10.0];
        self.title.textColor = [UIColor timeRowHeaderTitleColor];
        [self addSubview:self.title];
        
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.right.equalTo(self.mas_right).offset(-5.0);
        }];
    }
    return self;
}

#pragma mark - MSTimeRowHeader

- (void)setTime:(NSDate *)time
{
    _time = time;
    
    static NSDateFormatter *dateFormatter;
    if (!dateFormatter) {
        dateFormatter = [NSDateFormatter new];
        dateFormatter.timeStyle = NSDateFormatterShortStyle;
        //TODO: Fix for English
    }
    self.title.text = [dateFormatter stringFromDate:time];
    [self setNeedsLayout];
}

@end

//
//  DayCell.m
//  playaround
//
//  Created by Yingang Xue on 6/24/14.
//  Copyright (c) 2014 Yingang Xue. All rights reserved.
//

#import "DayCell.h"

@implementation DayCell

@synthesize dayLabel;
@synthesize validMonthDay;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        dayLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:dayLabel];
    }
    return self;
}

-(void)setDayLabelText:(NSString*)text
{
    [dayLabel setText:text];
}

-(void)prepareForReuse
{
    [super prepareForReuse];
    dayLabel.text = nil;
    dayLabel.backgroundColor = [UIColor whiteColor];
    dayLabel.enabled = YES;
    dayLabel.highlighted = NO;
    validMonthDay = NO;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

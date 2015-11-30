//
//  FFHeaderMonthForYearCell.m
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 3/13/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import "FFHeaderMonthForYearCell.h"

#import "FFImportantFilesForCalendar.h"

@interface FFHeaderMonthForYearCell ()
@property (nonatomic, strong) UILabel *labelTitle;
@end

@implementation FFHeaderMonthForYearCell

#pragma mark - Synthesize

@synthesize date;
@synthesize labelTitle;

#pragma mark - Lifecycle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark - Custom Methods

- (void)addWeekLabelsWithSizeOfCells:(CGSize)sizeOfCells {
    
    if (!labelTitle) {
        
        //Week on the top label Of the month size setting in each cell 
        CGFloat height = self.frame.size.height/4.;
        
        labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(0., 0., self.frame.size.width, height)];
        [labelTitle setTextColor:[UIColor redColor]];
        [self addSubview:labelTitle];
        
        for (int i = 0; i < [arrayWeekAbrev count]; i++) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i*sizeOfCells.width, labelTitle.frame.size.height,5,60)];
            [label setTextAlignment:NSTextAlignmentCenter];
            [label setText:[arrayWeekAbrev objectAtIndex:i]];
            [label setTextColor:[UIColor blackColor]];
//            [label setFont:[UIFont boldSystemFontOfSize:label.font.pointSize+15]];
            [self addSubview:label];
        }
    }
    
    [labelTitle setText:[[arrayMonthName objectAtIndex:(date.componentsOfDate.month-1)] uppercaseString]];
}


@end

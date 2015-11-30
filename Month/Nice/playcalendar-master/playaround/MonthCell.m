//
//  MonthCell.m
//  playaround
//
//  Created by Yingang Xue on 7/2/14.
//  Copyright (c) 2014 Yingang Xue. All rights reserved.
//

#import "MonthCell.h"

@implementation MonthCell

@synthesize calendarView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        float cx = 0;
        float cy = 0;
        float cw = self.bounds.size.width;
        float ch = self.bounds.size.height;
        CGRect calendarRect = CGRectMake(cx, cy, cw, ch);

        UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
        
        calendarView = [[UICollectionView alloc] initWithFrame:calendarRect collectionViewLayout:flowlayout];
        
        self.calendarView.backgroundColor=[UIColor whiteColor];
    }
    return self;
}

-(void)prepareForReuse
{
    [super prepareForReuse];
    [calendarView reloadData];
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

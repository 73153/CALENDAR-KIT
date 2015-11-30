//
//  SACalendarCell.m
//  SACalendarExample
//
//  Created by Nop Shusang on 7/12/14.
//  Copyright (c) 2014 SyncoApp. All rights reserved.
//
//  Distributed under MIT License

#import "SACalendarCell.h"
#import "FTCalendarAppearance.h"

@implementation SACalendarCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = cellBackgroundColor;
        
        self.topLineView = [[UIView alloc]initWithFrame:CGRectMake(-1, 5, frame.size.width + 2, .4f)];
        self.topLineView.backgroundColor = cellTopLineColor;
        
        self.dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, frame.size.width, frame.size.height)];
        self.dateLabel.textAlignment = NSTextAlignmentCenter;
        
        CGRect labelFrame = self.dateLabel.frame;
        CGSize labelSize = labelFrame.size;
        
        CGPoint origin;
        int length;
        if (labelSize.width > labelSize.height) {
            origin.x = (labelSize.width - labelSize.height * circleToCellRatio) / 2;
            origin.y = (labelSize.height * (1 - circleToCellRatio)) / 2;
            length = (labelSize.height * circleToCellRatio) - 4.0f;
        }
        else{
            origin.x = (labelSize.width * (1 - circleToCellRatio)) / 2;
            origin.y = (labelSize.height - labelSize.width * circleToCellRatio) / 2;
            length = (labelSize.width * circleToCellRatio) - 4.0f;
        }
        
        self.circleView = [[UIView alloc] initWithFrame:CGRectMake(origin.x, origin.y + 4.5, length, length)];
        
        self.circleView.layer.cornerRadius = length / 2;
        self.circleView.backgroundColor = currentDateCircleColor;
        self.circleView.center = self.dateLabel.center;

        
        self.selectedView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, length, length)];
        
        self.selectedView.layer.cornerRadius = length / 2;
        self.selectedView.backgroundColor = selectedDateCircleColor;
        self.selectedView.center = self.dateLabel.center;
        
        [self.viewForBaselineLayout addSubview:self.topLineView];
        [self.viewForBaselineLayout addSubview:self.circleView];
        [self.viewForBaselineLayout addSubview:self.selectedView];
        [self.viewForBaselineLayout addSubview:self.dateLabel];
        
    }
    return self;
}

@end

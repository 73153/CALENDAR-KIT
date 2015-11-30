//
//  DayCell.h
//  playaround
//
//  Created by Yingang Xue on 6/24/14.
//  Copyright (c) 2014 Yingang Xue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DayCell : UICollectionViewCell

@property (nonatomic,retain) UILabel *dayLabel;
@property (nonatomic,assign) BOOL validMonthDay;

-(void)setDayLabelText:(NSString*)text;

@end

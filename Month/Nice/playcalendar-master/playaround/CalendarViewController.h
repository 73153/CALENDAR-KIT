//
//  CalendarViewController.h
//  playaround
//
//  Created by Yingang Xue on 6/23/14.
//  Copyright (c) 2014 Yingang Xue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircleProgressView.h"

@interface CalendarViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CircularProgressViewDelegate>
{
    NSArray *cellsInMonth;
    int numberOfDays;
    int currentMonth;
    int currentYear;

    int cellViewMonth;//cell 显示哪个月份看这个参数
    BOOL scrollDirectionDetermined;
    CircleProgressView *cp;
}

@property (nonatomic,retain) UICollectionView *monthsView;


@end

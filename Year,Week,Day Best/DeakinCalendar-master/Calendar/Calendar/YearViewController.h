//
//  YearViewController.h
//  Calendar
//
//  Created by RunliSong on 01/02/2015.
//  Copyright (c) 2015 Deakin University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YearViewController : UIViewController <UICollectionViewDelegate,UICollectionViewDataSource>
@property  NSInteger currentYear;
@property  NSInteger selectedMonth;


@end

//
//  DayViewController.h
//  Calendar
//
//  Created by RunliSong on 01/02/2015.
//  Copyright (c) 2015 Deakin University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DayViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic) NSInteger weekdaytitle;
@property (nonatomic) NSInteger datenum;
@property (nonatomic) NSString *monthTitle;
@property (nonatomic) NSInteger monthOfTheDay;
@property (nonatomic) NSInteger yearOfTheDay;
@property (nonatomic) NSDate *pickedDate;
@end

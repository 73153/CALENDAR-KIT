//
//  ViewController.m
//  FTCalendar
//
//  Created by Mousa AlSahbi on 1/29/15.
//  Copyright (c) 2015 Future Thoughts. All rights reserved.
//

#import "ViewController.h"
#import "FTCalendar.h"

@interface ViewController ()<FTCalendarDelegate>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    FTCalendar *calendar = [[FTCalendar alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 250)
                                            scrollDirection:ScrollDirectionVertical
                                              pagingEnabled:YES];
    
    
    
    calendar.delegate = self;
    calendar.calendarDateFormatter = FTCalendarDateFormatterDayMonthYear;
    
    [self.view addSubview:calendar];

}

- (void)didSelectDate:(int)day month:(int)month year:(int)year
{
    NSLog(@"%i/%i/%i",day,month,year);
}

- (void)didSelectDateString:(NSString *)dateString
{
    
}

@end

//
//  FTCalendar.h
//  FTCalendar
//
//  Created by Mousa AlSahbi on 1/28/15.
//  Copyright (c) 2015 SyncoApp. All rights reserved.
//

#import "SACalendar.h"

typedef NS_ENUM(NSUInteger, FTCalendarDateFormatter)
{
    FTCalendarDateFormatterYearMonthDay,
    FTCalendarDateFormatterDayMonthYear,
};

@interface FTCalendar : SACalendar

@property (nonatomic) FTCalendarDateFormatter calendarDateFormatter;

@property (nonatomic, strong) NSArray *availableDates;

@end

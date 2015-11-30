//
//  SACalendarConstants.h
//  SACalendar
//
//  User Interface constants. Customize your calendar here.
//
//  Created by Nop Shusang on 7/14/14.
//  Copyright (c) 2014 SyncoApp. All rights reserved.
//
//  Distributed under MIT License

#import <Foundation/Foundation.h>

/**
 *  Constants. Do not change
 */
#define MAX_MONTH 12
#define MIN_MONTH 1
#define MAX_CELL 42
#define DESELECT_ROW -1
#define DAYS_IN_WEEKS 7
#define MAX_WEEK 6

/**
 *  Calendar's proportion
 */
#define calendarToHeaderRatio 7
#define headerFontRatio 0.4

#define cellFontRatio 0.3
#define labelToCellRatio 0.7
#define circleToCellRatio 0.8

/**
 * Calendar's color
 */

#define viewBackgroundColor [UIColor blackColor]
#define scrollViewBackgroundColor [UIColor whiteColor]
#define calendarBackgroundColor [UIColor whiteColor]

#define headerTextColor [UIColor colorWithRed:83.0f/255.0f green:39.0f/255.0f blue:111.0f/255.0f alpha:1.0f]

// All cells
#define cellFont [UIFont systemFontOfSize:12.0f]
#define cellBoldFont [UIFont boldSystemFontOfSize:12.0f]

#define cellBackgroundColor [UIColor whiteColor]
#define cellTopLineColor [UIColor lightGrayColor]

#define dateTextColor [UIColor blackColor]

// Current date's cell
#define currentDateCircleColor [UIColor colorWithRed:83.0f/255.0f green:39.0f/255.0f blue:111.0f/255.0f alpha:1.0f]
#define currentDateTextColor [UIColor whiteColor]

// Selected date's cell
#define selectedDateCircleColor [UIColor colorWithRed:224.0f/255.0f green:19.0f/255.0f blue:122.0f/255.0f alpha:1.0f]
#define selectedDateTextColor [UIColor whiteColor]


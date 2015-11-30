//
//  SACalendar.h
//  SACalendarExample
//
//  Created by Nop Shusang on 7/10/14.
//  Copyright (c) 2014 SyncoApp. All rights reserved.
//
//  Distributed under MIT License

#import <UIKit/UIKit.h>

/*
 * Loading states for infinite scroll view is to load the scroll view on the left (previous) first
 * the load the scroll view on the right (next) and finally load the scroll view in the middle (current)
 */
typedef enum {
    LOADSTATESTART = -1,
    LOADSTATEPREVIOUS = 0,
    LOADSTATENEXT,
    LOADSTATECURRENT
} loadStates;


/*
 * Since we are reusing the scroll views, we need to define the three possible scroll views' position
 * Assuming that the scroll views are called 0,1,2 then the three states are
 * 0 1 2, 2 0 1, and 1 2 0
 */
typedef enum {
    SCROLLSTATE_120 = 0,
    SCROLLSTATE_201 = 1,
    SCROLLSTATE_012}
scrollStates;

/**
 *  Scroll view's scroll direction
 */
typedef enum {
    ScrollDirectionHorizontal = 0,
    ScrollDirectionVertical = 1
}
scrollDirection;


@protocol FTCalendarDelegate;

@class DMLazyScrollView;
@interface SACalendar : UIView <UICollectionViewDataSource, UICollectionViewDelegate>
{
    DMLazyScrollView    *scrollView;
    NSMutableDictionary *controllers;
    NSMutableDictionary *calendars;
    NSMutableDictionary *monthLabels;
    
    int year, month;
    int prev_year, prev_month;
    int next_year, next_month;
    int current_date, current_month, current_year;
    
    int state, scroll_state;
    int previousIndex;
    BOOL scrollLeft;
    
    int firstDay;
    NSArray *daysInWeeks;
    CGSize cellSize;
    
    int selectedRow;
    int headerSize;
}

@property (nonatomic, weak) id<FTCalendarDelegate> delegate;

@property (nonatomic, retain) NSString *selectedDate;
@property (nonatomic) NSInteger collectionViewTag;

/**
 *  Default constructor. Calendar will begin at current month
 *
 *  @param frame of the calendar
 *
 *  @return initialized calendar
 */
- (id)initWithFrame:(CGRect)frame;

/**
 *  Begin calendar at specific month and year
 *
 *  @param frame of the calendar
 *  @param m     month to begin calendar
 *  @param y     year to begin calendar
 *
 *  @return initialized calendar starting at mm/yyyy
 */
- (id)initWithFrame:(CGRect)frame month:(int)m year:(int)y;

/**
 *  Calendar will begin at current month. The user can also specify other properties
 *
 *  @param frame     of the calendar
 *  @param direction scroll direction, default to horizontal
 *  @param paging    paging enabled, default to yes
 *
 *  @return initialized calendar
 */
-(id)initWithFrame:(CGRect)frame
   scrollDirection:(scrollDirection)direction
     pagingEnabled:(BOOL)paging;

/**
 *  The complete constructor
 *
 *  @param frame     of the calendar
 *  @param m         month to begin calendar
 *  @param y         year to begin calendar
 *  @param direction scroll direction, default to horizontal
 *  @param paging    paging enabled, default to yes
 *
 *  @return initialized calendar
 */
-(id)initWithFrame:(CGRect)frame
             month:(int)m year:(int)y
   scrollDirection:(scrollDirection)direction
     pagingEnabled:(BOOL)paging;

/**
 *  Get the month corresponding to the collection view
 *
 *  @param tag of the collection view
 *
 *  @return month that the collection view should load
 */
-(int)monthToLoad:(int)tag;

/**
 *  Get the year corresponding to the collection view
 *
 *  @param tag of the collection view
 *
 *  @return year that the collection view should load
 */
-(int)yearToLoad:(int)tag;
@end

@protocol FTCalendarDelegate <NSObject>
@optional

/**
 *  A delegate function that get called once the calendar changed to display a different month.
 *  This is caused by swiping left or right
 *
 *  @param month    The new month displayed
 *  @param year     The new year displayed
 */
-(void)didDisplayCalendarForMonth:(int)month year:(int)year;

/**
 *  This function get called when a specific date is selected
 *
 *  @param day      The date selected
 *  @param month    The month selected
 *  @param year     The year selected
 */
-(void)didSelectDate:(int)day month:(int)month year:(int)year;
-(void)didSelectDateString:(NSString *)dateString;


@end
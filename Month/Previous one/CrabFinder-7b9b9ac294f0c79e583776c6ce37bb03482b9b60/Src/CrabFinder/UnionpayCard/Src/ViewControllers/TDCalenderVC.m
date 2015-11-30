//
//  TDCalenderVC.m
//  UnionpayCard
//
//  Created by Dong Yiming on 3/18/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDCalenderVC.h"
#import <MBCalendarKit/CalendarKit.h>
#import <MBCalendarKit/NSDate+Components.h>
#import "TDEvent.h"
#import "TDCalenderDayVC.h"

@interface TDCalenderVC () <CKCalendarViewDelegate, CKCalendarViewDataSource>
{
    CKCalendarView  *_calendarView;
    NSMutableArray         *_events;
}

@end

@implementation TDCalenderVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Calendar";
    
    _events = [NSMutableArray array];
    
    TDEvent *event = [TDEvent new];
    event.name = @"Walmart";
    event.time = [NSDate dateWithDay:18 month:3 year:2014];
    event.rating = 3.5;
    [_events addObject:event];
    
    event = [TDEvent new];
    event.name = @"Farmer's Market Name";
    event.time = [NSDate dateWithDay:18 month:3 year:2014];
    event.rating = 5;
    [_events addObject:event];
    
    event = [TDEvent new];
    event.name = @"Farmer's Market Name";
    event.time = [NSDate dateWithDay:18 month:3 year:2014];
    event.rating = 5;
    [_events addObject:event];
    
    event = [TDEvent new];
    event.name = @"Farmer's Market Name";
    event.time = [NSDate dateWithDay:18 month:3 year:2014];
    event.rating = 5;
    [_events addObject:event];
    
    [self installSearchToNavibar];
    
    
    [self initViews];
    [self setupViews];
}

-(void)initViews {
    _calendarView = [CKCalendarView new];
    [_calendarView setDelegate:self];
    [_calendarView setDataSource:self];
    [[self view] addSubview:_calendarView];
}

-(void)setupViews {
    //[_calendarView alignToView:self.view];
}

#pragma mark -
- (NSArray *)calendarView:(CKCalendarView *)calendarView eventsForDate:(NSDate *)date {
    NSMutableArray *calenderEvents = [NSMutableArray array];
    for (TDEvent *event in _events) {
        if ([event.time timeIntervalSinceDate:date] == 0) {
            CKCalendarEvent *calendarEvent = [CKCalendarEvent eventWithTitle:event.name andDate:event.time andInfo:@{@"info" : event}];
            [calenderEvents addObject:calendarEvent];
        }
    }
    return calenderEvents;
}

- (void)calendarView:(CKCalendarView *)CalendarView willSelectDate:(NSDate *)date {
    
}

- (void)calendarView:(CKCalendarView *)CalendarView didSelectDate:(NSDate *)date {
    DLog(@"date:%@ tapped", date);
    NSArray *calendarEvents = [self calendarView:CalendarView eventsForDate:date];
    if (calendarEvents.count > 0) {
        TDCalenderDayVC *vc = [TDCalenderDayVC new];
        vc.calendarEvents = calendarEvents;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)calendarView:(CKCalendarView *)CalendarView didSelectEvent:(CKCalendarEvent *)event {
    DLog(@"event:%@ tapped", event.title);
}

@end

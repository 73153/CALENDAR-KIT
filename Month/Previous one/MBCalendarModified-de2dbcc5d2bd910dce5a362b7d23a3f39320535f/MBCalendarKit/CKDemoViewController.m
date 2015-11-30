//
//  CKDemoViewController.m
//  MBCalendarKit
//
//  Created by Moshe Berman on 4/17/13.
//  Copyright (c) 2013 Moshe Berman. All rights reserved.
//

#import "CKDemoViewController.h"

#import "NSCalendarCategories.h"
#import "CKEventDetailViewController.h"

#import "NSDate+Components.h"

@interface CKDemoViewController () <CKCalendarViewDelegate, CKCalendarViewDataSource>
    @property (nonatomic, strong) NSMutableDictionary *data;
@end

@implementation CKDemoViewController

- (id)init
{
    self = [super init];
    if (self) {
        [self setDataSource:self];
        [self setDelegate:self];
        self.data = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{

    //self.navigationController.navigationItem.rightBarButtonItem
    [super viewDidLoad];



	// Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    /*
    NSDate *min = [NSDate dateWithDay:10 month:4 year:2013];
    NSDate *max = [NSDate dateWithDay:20 month:4 year:2013];
    
    [[self calendarView] setMaximumDate:max];
    [[self calendarView] setMinimumDate:min];
     */
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - CKCalendarViewDataSource

- (NSArray *)calendarView:(CKCalendarView *)calendarView eventsForDate:(NSDate *)date
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:kCFCalendarUnitDay | kCFCalendarUnitMonth | kCFCalendarUnitYear fromDate:date];
    NSInteger day = [components day];
    NSInteger month = [components month];
    NSInteger year = [components year];
    date = [NSDate dateWithDay:day month:month year:year];
    return [self data][date];
}

- (void)calendarView:(CKCalendarView *)calendarView addEvent: (CKCalendarEvent *) event toDate:(NSDate *)date
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:kCFCalendarUnitDay | kCFCalendarUnitMonth | kCFCalendarUnitYear fromDate:date];
    NSInteger day = [components day];
    NSInteger month = [components month];
    NSInteger year = [components year];
    date = [NSDate dateWithDay:day month:month year:year];
    [event setDate:date];
    
    //get events for date and update nsarray
    NSArray *events;
    if (![self data][date]){
        events = [NSArray new];
    }else{
        events = [self data][date];
    }
    
    NSMutableArray *mutEvents = [events mutableCopy];
    [mutEvents addObject:event];
    NSArray *array = [mutEvents copy];
    
    //update data with this new nsarray
    NSMutableDictionary *temp = self.data;
    [temp setObject:array forKey:date];
    self.data = temp;
   // [calendarView reload];
}

#pragma mark - CKCalendarViewDelegate

// Called before/after the selected date changes
- (void)calendarView:(CKCalendarView *)CalendarView willSelectDate:(NSDate *)date
{

}

- (void)calendarView:(CKCalendarView *)CalendarView didSelectDate:(NSDate *)date
{
    
}

//  A row is selected in the events table. (Use to push a detail view or whatever.)
- (void)calendarView:(CKCalendarView *)CalendarView didSelectEvent:(CKCalendarEvent *)event
{
    CKEventDetailViewController *temp = [[CKEventDetailViewController alloc] initWithNibName:@"CKEventDetail" andEvent:event bundle:nil];
    
    [self presentViewController:temp animated:YES completion:nil];
}
@end

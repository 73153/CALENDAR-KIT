//
//  CKViewController.m
//   MBCalendarKit
//
//  Created by Moshe Berman on 4/10/13.
//  Copyright (c) 2013 Moshe Berman. All rights reserved.
//

#import "CKCalendarViewControllerInternal.h"

#import "CKCalendarView.h"

#import "CKCalendarEvent.h"

#import "NSCalendarCategories.h"

#import "NSString+Color.h"

@interface CKCalendarViewControllerInternal () <CKCalendarViewDataSource, CKCalendarViewDelegate>

@property (nonatomic, strong) CKCalendarView *calendarView;

@property (nonatomic, strong) NSMutableArray *events;

@property (nonatomic, strong) UIBarButtonItem *todayButton;

@end

@implementation CKCalendarViewControllerInternal 

- (void)viewDidLoad
{
    
    [super viewDidLoad];

    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    
    [self setTitle:@"日程总览"];

    /* Prepare the events array */
    
    [self setEvents:[NSMutableArray new]];
    
    [[self view] setBackgroundColor:[@"#F8F6F8" toColor]];
    
    /* Calendar View */

    [self setCalendarView:[CKCalendarView new]];
    [[self calendarView] setDataSource:self];
    [[self calendarView] setDelegate:self];
    [[self calendarView] setFrame:CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height)];
    [[self view] addSubview:[self calendarView]];
    [[self calendarView] setCalendar:[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] animated:NO];
    [[self calendarView] setDisplayMode:CKCalendarViewModeWeek animated:NO];
    [self calendarView].backgroundColor = [UIColor clearColor];
    
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithTitle:@"back" style:UIBarButtonItemStyleBordered target:self action:@selector(backButtonTapped:)];
    self.navigationItem.leftBarButtonItem = btn;

}

- (void)backButtonTapped: (id)sender
{
    [self.navigationController popViewControllerAnimated: YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Toolbar Items

- (void)todayButtonTapped:(id)sender
{
    [[self calendarView] setDate:[NSDate date] animated:NO];
}

- (void)monthButtonTapped:(id)sender
{
    [[self calendarView] setDisplayMode:CKCalendarViewModeMonth];
}

- (void)weekButtonTapped:(id)sender
{
    [[self calendarView] setDisplayMode:CKCalendarViewModeWeek];
}

- (void)dayButtonTapped:(id)sender
{
    [[self calendarView] setDisplayMode:CKCalendarViewModeDay];
}


#pragma mark - CKCalendarViewDataSource

- (NSArray *)calendarView:(CKCalendarView *)CalendarView eventsForDate:(NSDate *)date
{
    if ([[self dataSource] respondsToSelector:@selector(calendarView:eventsForDate:)]) {
        return [[self dataSource] calendarView:CalendarView eventsForDate:date];
    }
    return nil;
}

#pragma mark - CKCalendarViewDelegate

// Called before/after the selected date changes
- (void)calendarView:(CKCalendarView *)calendarView willSelectDate:(NSDate *)date
{
    if ([self isEqual:[self delegate]]) {
        return;
    }
    
    if ([[self delegate] respondsToSelector:@selector(calendarView:willSelectDate:)]) {
        [[self delegate] calendarView:calendarView willSelectDate:date];
    }
}

- (void)calendarView:(CKCalendarView *)calendarView didSelectDate:(NSDate *)date
{
    if ([self isEqual:[self delegate]]) {
        return;
    }
    
    if ([[self delegate] respondsToSelector:@selector(calendarView:didSelectDate:)]) {
        [[self delegate] calendarView:calendarView didSelectDate:date];
    }
}

//  A row is selected in the events table. (Use to push a detail view or whatever.)
- (void)calendarView:(CKCalendarView *)calendarView didSelectEvent:(CKCalendarEvent *)event withCell:(UITableViewCell *)cell
{
    if ([self isEqual:[self delegate]]) {
        return;
    }
    
    if ([[self delegate] respondsToSelector:@selector(calendarView:didSelectEvent:withCell:)]) {
        [[self delegate] calendarView:calendarView didSelectEvent:event withCell:cell];
    }
}

#pragma mark - Calendar View

- (CKCalendarView *)calendarView
{
    return _calendarView;
}
@end

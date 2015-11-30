//
//  Utilities.h
//  Calendar
//
//  Created by Peng Gao on 21/01/2015.
//  Copyright (c) 2015 Deakin University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Event.h"
#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>

@interface Utilities : NSObject

// will return a random color (RGB)
+ (UIColor *)randomColor;

// days' detail for all days in a specific month
- (NSArray *)getAllDaysOfMonth:(int) month inYear:(int)year;

+ (BOOL)addEvent: (Event *)event;
+ (NSArray *)getAllEvents; // will return an array of NSManagedObject, each item can be cast as Event
+ (BOOL)updateEvent: (NSManagedObject *)event withNewValue: (Event *)newValue;
+ (BOOL)deleteEvent: (NSManagedObject *)event;

// this method should be used in Month view and Day view
+ (NSArray *)getEventsBetweenDate:(NSDate *) startDate andEndDate:(NSDate *)endDate;

+ (NSArray *)getEventsWithTitle:(NSString *) eventTitle description:(NSString *)desc startDate:(NSDate *) startDate andEndDate:(NSDate *)endDate; // Use this method, any value can be nil

@end

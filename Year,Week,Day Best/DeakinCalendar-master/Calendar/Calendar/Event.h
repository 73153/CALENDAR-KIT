//
//  Event.h
//  Calendar
//
//  Created by Peng Gao on 19/01/2015.
//  Copyright (c) 2015 Deakin University. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Event : NSObject

@property (strong, nonatomic) NSString *title; // of event
@property (strong, nonatomic) NSString *desc; //Description of an event


@property (strong, nonatomic) NSString *localName; // e.g. Pacific Standard Time
@property (strong, nonatomic) NSString *localID; // e.g. America/Los_Angeles
@property (strong, nonatomic) NSNumber *localUTC; // Range from -12 to +12
@property (strong, nonatomic) NSDate *localTime; // Local date and time of the event occurs

@property (strong, nonatomic) NSString *otherName; // e.g. Pacific Standard Time
@property (strong, nonatomic) NSString *otherID; // e.g. America/Los_Angeles
@property (strong, nonatomic) NSNumber *otherUTC; // Range from -12 to 12
@property (strong, nonatomic) NSDate *otherTime; // The date and time of another time zone;

- (instancetype) initWithTitle: (NSString *) title
                   description: (NSString *)desc
                 localZoneName: (NSString *)localName
                   localZoneID: (NSString *)localID
                  localZoneUTC: (NSNumber *)localUTC
                     localTime: (NSDate *) localTime
                 otherZoneName: (NSString *)otherName
                   otherZoneID: (NSString *)otherID
                  otherZoneUTC: (NSNumber *)otherUTC
                 otherZoneTime: (NSDate *) otherTime;


@end

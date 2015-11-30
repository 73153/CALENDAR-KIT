//
//  Event.m
//  Calendar
//
//  Created by Peng Gao on 19/01/2015.
//  Copyright (c) 2015 Deakin University. All rights reserved.
//

#import "Event.h"

@implementation Event

- (instancetype)initWithTitle:(NSString *)title description:(NSString *)desc localZoneName:(NSString *)localName localZoneID:(NSString *)localID localZoneUTC:(NSNumber *)localUTC localTime:(NSDate *)localTime otherZoneName:(NSString *)otherName otherZoneID:(NSString *)otherID otherZoneUTC:(NSNumber *)otherUTC otherZoneTime:(NSDate *)otherTime {
    self = [super init];
    if (self) {
        _title = title;
        _desc = desc;
        _localTime = localTime;
        _localName = localName;
        _localUTC = localUTC;
        _localID = localID;
        _otherID = otherID;
        _otherName = otherName;
        _otherTime = otherTime;
        _otherUTC = otherUTC;
    }
    return self;
}
@end

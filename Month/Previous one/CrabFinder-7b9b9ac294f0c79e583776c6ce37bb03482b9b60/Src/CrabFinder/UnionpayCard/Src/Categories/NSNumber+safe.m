//
//  NSNumber+safe.m
//  OneStore
//
//  Created by towne on 14-2-20.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//

#import "NSNumber+safe.h"

@implementation NSNumber (safe)

- (BOOL)safeIsEqualToNumber:(NSNumber *)number
{
    if (number == nil) {
        return NO;
    } else {
        return [self isEqualToNumber:number];
    }
}

- (NSComparisonResult)safeCompare:(NSNumber *)otherNumber
{
    if (otherNumber == nil) {
        return NSOrderedDescending;
    } else {
        return [self compare:otherNumber];
    }
}

@end

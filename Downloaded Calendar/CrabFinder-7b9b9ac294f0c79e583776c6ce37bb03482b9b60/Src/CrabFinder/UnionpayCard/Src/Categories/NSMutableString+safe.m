//
//  NSMutableString+safe.m
//  OneStore
//
//  Created by towne on 14-2-20.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//
#import "NSMutableString+safe.h"

@implementation NSMutableString(safe)

- (void)safeInsertString:(NSString *)aString atIndex:(NSUInteger)loc
{
    if (aString == nil) {
        return;
    } else if (loc > self.length) {
        return;
    } else {
        [self insertString:aString atIndex:loc];
    }
}

- (void)safeAppendString:(NSString *)aString
{
    if (aString == nil) {
        return;
    } else {
        [self appendString:aString];
    }
}

- (void)safeSetString:(NSString *)aString
{
    if (aString == nil) {
        return;
    } else {
        [self setString:aString];
    }
}

- (NSUInteger)safeReplaceOccurrencesOfString:(NSString *)target withString:(NSString *)replacement options:(NSStringCompareOptions)options range:(NSRange)searchRange
{
    int location = searchRange.location;
    int length = searchRange.length;
    if (target==nil || replacement==nil) {
        return 0;
    } else if (location<0 || location+length>self.length) {
        return 0;
    } else {
        return [self replaceOccurrencesOfString:target withString:replacement options:options range:searchRange];
    }
}

@end

//
//  NSMutableString+safe.h
//  OneStore
//
//  Created by towne on 14-2-20.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface NSMutableString(safe)

- (void)safeInsertString:(NSString *)aString atIndex:(NSUInteger)loc;

- (void)safeAppendString:(NSString *)aString;

- (void)safeSetString:(NSString *)aString;

- (NSUInteger)safeReplaceOccurrencesOfString:(NSString *)target withString:(NSString *)replacement options:(NSStringCompareOptions)options range:(NSRange)searchRange;

@end

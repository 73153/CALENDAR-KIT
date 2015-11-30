//
//  NSArray+safe.h
//  OneStore
//
//  Created by towne on 14-2-20.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Safe)

- (id)safeObjectAtIndex:(NSUInteger)index;

+ (instancetype)safeArrayWithObject:(id)object;

- (NSArray *)safeSubarrayWithRange:(NSRange)range;

@end

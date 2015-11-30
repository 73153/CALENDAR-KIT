//
//  NSMutableArray+safe.m
//  OneStore
//
//  Created by towne on 14-2-20.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//

#import "NSMutableArray+safe.h"
#import "NSObject+swizzle.h"

@implementation NSMutableArray (safe)

+ (void)load
{
    [self overrideMethod:@selector(setObject:atIndexedSubscript:) withMethod:@selector(safeSetObject:atIndexedSubscript:)];
}

- (void)safeSetObject:(id)obj atIndexedSubscript:(NSUInteger)idx
{
    if (obj == nil) {
        return ;
    }

    if (self.count < idx) {
        return ;
    }

    if (idx == self.count) {
        [self addObject:obj];
    } else {
        [self replaceObjectAtIndex:idx withObject:obj];
    }
}

- (void)safeAddObject:(id)object
{
	if (object == nil) {
		return;
	} else {
        [self addObject:object];
    }
}

- (void)safeInsertObject:(id)object atIndex:(NSUInteger)index
{
	if (object == nil) {
		return;
	} else if (index > self.count) {
		return;
	} else {
        [self insertObject:object atIndex:index];
    }
}

- (void)safeInsertObjects:(NSArray *)objects atIndexes:(NSIndexSet *)indexs
{
    int firstIndex = indexs.firstIndex;
    if (indexs == nil) {
        return;
    } else if (indexs.count!=objects.count || firstIndex<0 || firstIndex>objects.count) {
        return;
    } else {
        [self insertObjects:objects atIndexes:indexs];
    }
}

- (void)safeRemoveObjectAtIndex:(NSUInteger)index
{
	if (index >= self.count) {
		return;
	} else {
        [self removeObjectAtIndex:index];
    }
}

- (void)safeRemoveObjectsInRange:(NSRange)range
{
    int location = range.location;
    int length = range.length;
    if (location<0 || location+length>self.count) {
        return;
    } else {
        return [self removeObjectsInRange:range];
    }
}

@end

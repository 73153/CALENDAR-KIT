//
//  NSNumber+otsCopy.m
//  OneStore
//
//  Created by towne on 14-2-20.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//

#import "NSNumber+otsCopy.h"

@implementation NSNumber (otsCopy)

-(NSNumber*)copyBool
{
    return [NSNumber numberWithBool:self.boolValue];
}

-(NSNumber*)copyInt
{
    return [NSNumber numberWithInt:self.intValue];
}

-(NSNumber*)copyLong
{
    return [NSNumber numberWithLong:self.longValue];
}

-(NSNumber*)copyLongLong
{
    return [NSNumber numberWithLongLong:self.longLongValue];
}

-(NSNumber*)copyFloat
{
    return [NSNumber numberWithFloat:self.floatValue];
}

-(NSNumber*)copyDouble
{
    return [NSNumber numberWithDouble:self.doubleValue];
}


@end


@implementation NSNumber (otsOperator)

-(NSNumber*)addInt:(int)aValue
{
    return [NSNumber numberWithLongLong:self.longLongValue + aValue];
}

-(NSNumber*)addDouble:(double)aValue
{
    return [NSNumber numberWithDouble:self.doubleValue + aValue];
}

-(NSNumber*)minusInt:(int)aValue
{
    return [NSNumber numberWithLongLong:self.longLongValue - aValue];
}

-(NSNumber*)minusDouble:(double)aValue
{
    return [NSNumber numberWithDouble:self.doubleValue - aValue];
}

-(NSNumber*)multipleInt:(int)aValue
{
    return [NSNumber numberWithLongLong:self.longLongValue * aValue];
}

-(NSNumber*)multipleDouble:(double)aValue
{
    return [NSNumber numberWithDouble:self.doubleValue * aValue];
}

-(NSNumber*)devideByInt:(int)aValue
{
    if (aValue == 0)
    {
        return nil;
    }
    
    return [NSNumber numberWithLongLong:self.longLongValue / aValue];
}

-(NSNumber*)devideByDouble:(double)aValue
{
    if (aValue == 0)
    {
        return nil;
    }
    
    return [NSNumber numberWithDouble:self.doubleValue / aValue];
}

-(NSNumber*)modByInt:(int)aValue
{
    if (aValue == 0)
    {
        return nil;
    }
    
    return [NSNumber numberWithDouble:self.intValue % aValue];
}


@end


@implementation NSNumber (otsFormatString)

-(NSString *)moneyFormatString
{
    NSString *priceString = [NSString stringWithFormat:@"¥%.2f", self.floatValue];
    NSString *endChar = [priceString safeSubstringWithRange:NSMakeRange(priceString.length-1, 1)];
    if ([endChar isEqualToString:@"0"]) {
        priceString = [priceString safeSubstringWithRange:NSMakeRange(0, priceString.length-1)];
    }
    return priceString;
}

+(NSString *)moneyFormat:(double)aValue
{
    NSString *priceString = [NSString stringWithFormat:@"¥%.2f", aValue];
    NSString *endChar = [priceString safeSubstringWithRange:NSMakeRange(priceString.length-1, 1)];
    if ([endChar isEqualToString:@"0"]) {
        priceString = [priceString safeSubstringWithRange:NSMakeRange(0, priceString.length-1)];
    }
    return priceString;
}

@end

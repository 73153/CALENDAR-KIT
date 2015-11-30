//
//  NSNumber+otsCopy.h
//  OneStore
//
//  Created by towne on 14-2-20.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (otsCopy)

-(NSNumber*)copyBool;
-(NSNumber*)copyInt;
-(NSNumber*)copyLong;
-(NSNumber*)copyLongLong;
-(NSNumber*)copyFloat;
-(NSNumber*)copyDouble;

@end

@interface NSNumber (otsOperator)

-(NSNumber*)addInt:(int)aValue;
-(NSNumber*)addDouble:(double)aValue;
-(NSNumber*)minusInt:(int)aValue;
-(NSNumber*)minusDouble:(double)aValue;
-(NSNumber*)multipleInt:(int)aValue;
-(NSNumber*)multipleDouble:(double)aValue;
-(NSNumber*)devideByInt:(int)aValue;
-(NSNumber*)devideByDouble:(double)aValue;
-(NSNumber*)modByInt:(int)aValue;           // 求余数

@end

@interface NSNumber (otsFormatString)

-(NSString *)moneyFormatString;

+(NSString *)moneyFormat:(double)aValue;
@end

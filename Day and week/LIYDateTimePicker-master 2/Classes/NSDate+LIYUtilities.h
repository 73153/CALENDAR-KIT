#import <Foundation/Foundation.h>

@interface NSDate (LIYUtilities)

//! example dateString: @"5/3/15, 11:45 PM"
+ (NSDate *)liy_dateFromString:(NSString *)dateString;

+ (NSDate *)dateFromDayDate:(NSDate *)dayDate timeDate:(NSDate *)timeDate;

- (NSDate *)dateAtHour:(NSUInteger)hour minute:(NSUInteger)minute;
- (BOOL)isSameDayAsDate:(NSDate *)date;

@end


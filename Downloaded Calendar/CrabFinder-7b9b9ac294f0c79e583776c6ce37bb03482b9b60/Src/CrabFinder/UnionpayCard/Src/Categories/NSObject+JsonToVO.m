//
//  NSObject+JsonToVO.m
//  OneStore
//
//  Created by towne on 14-2-20.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//

#import "NSObject+JsonToVO.h"
#import <objc/runtime.h>

@implementation NSObject (JsonToVO)

/**
 *  获取类名   voName是dictionary中标记实体类的类名的
 */
+ (NSString *)classNameWithDictionary:(NSDictionary*)dic
{
    if (!dic) {
        return nil;
    }
    //return [dic objectForKey:@"voName"];
    NSString *voName = nil;
    
    //根据dictinary中的key（datatype）获取到该dictionary对应的实体类名的描述
    NSString *dataTyepStr = [dic objectForKey:@"@datatype"];
    
    //判断类名描述存在则说明该dictionary是一个自定义的实体VO对象，否则就是一个dictionary类型类名返回nil不用映射
    if (dataTyepStr) {
        NSRange range = [dataTyepStr safeRangeOfString:@"." options:NSBackwardsSearch];
        if (range.location != NSNotFound) {
            voName = [dataTyepStr safeSubstringFromIndex:range.location + 1];
        }
    }
    return voName;
}

/**
 *  获取参数class类的所有属性
 */
- (NSMutableArray *)getPropertyList:(Class)class
{
	if ([ NSStringFromClass(class) isEqualToString:NSStringFromClass([NSObject class])]) {
		return nil;
    }
    u_int count;
    objc_property_t *properties = class_copyPropertyList(class, &count);
    NSMutableArray *propertyArray = [NSMutableArray arrayWithCapacity:count];

    for (int i = 0; i < count ; i++) {
        const char *propertyName = property_getName(properties[i]);
        const char *propertyType = property_getAttributes(properties[i]);
        NSMutableDictionary *propertyDic = [NSMutableDictionary dictionaryWithCapacity:0];
        [propertyDic safeSetObject:[NSString stringWithUTF8String: propertyName] forKey:@"propertyName"];
        [propertyDic safeSetObject:[NSString stringWithUTF8String: propertyType] forKey:@"propertyType"];
        [propertyArray safeAddObject:propertyDic];
    }
    free(properties);
	NSArray * superArray = [self getPropertyList:[class superclass]];
	if (superArray != nil) {
		[propertyArray addObjectsFromArray:superArray];
	}
    return propertyArray;
}

/**
 *  获取当前实体类的所有属性
 */
- (NSArray *)getPropertyList
{
	//tips：原先的方法没法处理超过两层继承的类
	 return [self getPropertyList:[self class]];
}

/**
 *  解析数组里面的对象
 */
+ (NSMutableArray *)setListWithArray:(NSMutableArray *)array
{
    if (!array) {
        return nil;
    }
    
    if (![array isKindOfClass:[NSMutableArray class]]) {
        return nil;
    }
    
    NSMutableArray *list = [[NSMutableArray alloc] initWithCapacity:[array count]];
    if ([array count] > 0) {
        for (id obj in array) {
            //如果是字典类型就转成VO
            if ([obj isKindOfClass:[NSDictionary class]]) {
                NSString *className = [NSObject classNameWithDictionary:obj];
                //判断类名存在则说明该dictionary是一个自定义的实体VO对象，否则就是一个dictionary类型不用映射直接添加到数组
                if (className) {
                    id subObj = [[NSClassFromString(className) alloc] initWithMyDictionary:obj];
                    if (subObj) {
                        [list safeAddObject:subObj];
                    }
                    continue;
                }
            }
            //如果是数组类型
            if ([obj isKindOfClass:[NSArray class]]) {
                NSMutableArray *subList = [self setListWithArray:obj];
                if (subList == nil) {
                    [list safeAddObject:[NSMutableArray arrayWithCapacity:0]];
                } else {
                    [list safeAddObject:subList];
                }
                
                continue;
            }
            
            [list safeAddObject:obj];
        }
    }
    return list;
}

/**
 *  将一个NSDictionary类型的数据里面的key值和VO的属性名一一对应赋value值
 */
- (void)setPropertysWithDictionary:(NSDictionary *)dict
{
    NSArray *propertys = [self  getPropertyList];
    int i;
    for (i=0; i<propertys.count; i++) {
        NSMutableDictionary *propertyDic = [propertys safeObjectAtIndex:i];
        NSString *propertyName = [propertyDic objectForKey:@"propertyName"];
        NSString *propertyType = [propertyDic objectForKey:@"propertyType"];
        id value = nil;
        if ([propertyName isEqualToString:@"nid"]) {
            value = [dict objectForKey:@"id"];
        } else {
            value = [dict objectForKey:propertyName];
        }

        if (!value) {
            continue;
        }
        
        //如果是字典类型的要继续转为对应的VO实体对象
        if ([value isKindOfClass:[NSDictionary class]]) {
            NSString* className = [NSObject classNameWithDictionary:value];
            //判断类名存在则说明该dictionary是一个自定义的实体VO对象，否则就是一个dictionary类型不用映射直接赋值
            if (className) {
                id subObj = [[NSClassFromString(className) alloc] initWithMyDictionary:value];
                if (subObj) {
                    [self setValue:subObj forKey:propertyName];
                }
                continue;
            }
        }
		
        
        //如果是数组
        if ([value isKindOfClass:[NSArray class]]) {
            NSMutableArray *list = [NSObject setListWithArray:value];
            [self setValue:list forKey:propertyName];
            continue;
        }
        
        if ([propertyType safeRangeOfString:@"NSDate"].location != NSNotFound) {//NSNumber转成NSDate
            if ([value isKindOfClass:[NSNumber class]]) {
                NSDate *dateValue = [NSDate dateWithTimeIntervalSince1970:((NSNumber*)value).doubleValue / 1000];
                [self setValue:dateValue forKey:propertyName];
            } else if ([value isKindOfClass:[NSString class]]) {
                NSDate *dateValue = nil;
                NSString *formatStr = @"yyyy-MM-dd HH:mm:ss";
                NSString *dateStr = (NSString *)value;
                int length = [formatStr length];
                if (dateStr.length >= length) {
                    if ([dateStr safeRangeOfString:@"UTC"].location!=NSNotFound || [dateStr safeRangeOfString:@"GMT"].location!=NSNotFound) {
                        NSString *subStr = [dateStr safeSubstringWithRange:NSMakeRange(0, length)];
                        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
                        [dateFormatter setDateFormat:formatStr];
                        dateValue = [dateFormatter dateFromString:subStr];
                    } else {
                        NSString *subStr = [dateStr safeSubstringWithRange:NSMakeRange(0, length)];
                        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                        [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
                        [dateFormatter setDateFormat:formatStr];
                        dateValue = [dateFormatter dateFromString:subStr];
                    }
                }
                if (dateValue == nil) {
                    dateValue = [NSDate date];
                }
                [self setValue:dateValue forKey:propertyName];
            }
        } else {
            [self setValue:value forKey:propertyName];
        }
    }
}

/*
 *  通过一个NSDictionary类型的数据构造一个VO类对象
 */
- (id)initWithMyDictionary:(NSDictionary *)dictionaryValue
{
    if (![dictionaryValue isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    [self setPropertysWithDictionary:dictionaryValue];
    
    return self;
}

/**
 *  判断一个value是否是能够转为json格式的基本数据类型
 */
- (BOOL)isValidTypeWithValue:(id)value
{
    //可以转为json格式的数据类型
    NSArray *validType = [NSArray arrayWithObjects:@"NSString", @"NSNumber", @"NSArray", @"NSDictionary",@"NSNull",nil];
    
    __block BOOL isValidType = NO;
    
    for (NSString *classStr in validType) {
        if ([value isKindOfClass:NSClassFromString(classStr)]) {
            isValidType = YES;
            break;
        }
    }
    return isValidType;
}

/**
 *  将一个VO类对象转为NSMutabileDictionary类型
 */
- (NSMutableDictionary *)convertDictionary
{
    if (!self) {
        return nil;
    }
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    NSArray *propertyList = [self getPropertyList];
    int i;
    for (i=0; i<propertyList.count; i++) {
        NSMutableDictionary *propertyDic = [propertyList safeObjectAtIndex:i];
        NSString *propertyName = [propertyDic objectForKey:@"propertyName"];

        if (!propertyName) {
            continue;
        }

        id value = [self valueForKey:propertyName];
        if (!value) {
            continue;
        }
    
        //如果不是转json的基本类型有可能是嵌套类对象
        if (![self isValidTypeWithValue:value]) {
            NSDictionary *dic = [value convertDictionary];
            if (dic) {
                [dictionary safeSetObject:dic forKey:propertyName];
            }
            continue;
        }
        
        //如果是数组
        if ([value isKindOfClass:[NSArray class]]) {
            NSMutableArray *list = [[NSMutableArray alloc] init];
            
            //判断数组中的对象如果不是转为json的基本类型那就是自定义的实体类对象
            [value enumerateObjectsUsingBlock:^(id obj,NSUInteger idx,BOOL *stop){
                
                if (![self isValidTypeWithValue:obj]) {
                    NSDictionary *dic = [obj convertDictionary];
                    if (dic) {
                        [dictionary safeSetObject:dic forKey:propertyName];
                        [list safeAddObject:dic];
                    }
                }
                else {
                    [list safeAddObject:obj];
                }
            }];
            
            [dictionary setValue:list forKey:propertyName];
            continue;
        }
        
        //如果是日期，NSDate转成NSNumber
        if ([value isKindOfClass:[NSDate class]]) {
            NSNumber *dateNum = @(((NSDate*)value).timeIntervalSince1970 * 1000);
            [dictionary setValue:dateNum forKey:propertyName];
            continue;
        }
        
        //转json的基本类型直接添加
        if ([propertyName isEqualToString:@"nid"]) {
            [dictionary setValue:value forKey:@"id"];
        } else {
            [dictionary setValue:value forKey:propertyName];
        }
    }
    return dictionary;
}

/**
 *  将vo对象转为json格式的字符串
 *  对象中的属性类型只能是：NSString NSNumber NSArray NSDictionary NSNull 或者是本地VO实体对象
 */
- (NSString *)toJsonStr
{
    if (!self) {
        return nil;
    }
    
    NSData *jsonData = nil;
    NSError *jsonError = nil;
    @try
    {
         if ([self isKindOfClass:[NSDictionary class]] || [self isKindOfClass:[NSArray class]]) {
             jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&jsonError];
         } else {
             NSDictionary *dict = [self convertDictionary];
             jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&jsonError];
         }
    }
    @catch (NSException *exception)
    {
        NSLog(@"to JSON string exception: %@", exception.description);
        return nil;
    }
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end

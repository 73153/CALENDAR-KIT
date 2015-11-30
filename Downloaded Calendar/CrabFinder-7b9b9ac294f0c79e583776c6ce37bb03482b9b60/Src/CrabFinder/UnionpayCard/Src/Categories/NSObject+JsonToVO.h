//
//  NSObject+JsonToVO.h
//  OneStore
//
//  Created by towne on 14-2-20.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (JsonToVO)

/*
 *  通过dicdtionary获取其中的VO对象的名称
 */
+ (NSString *)classNameWithDictionary:(NSDictionary *)dic;

/*
 *  通过一个NSDictionary类型的数据构造一个VO类对象
 */
- (id)initWithMyDictionary:(NSDictionary *)dictionaryValue;

/**
 *  解析数组里面的对象
 */
+ (NSMutableArray *)setListWithArray:(NSMutableArray *)array;

/**
 *  将一个VO类对象转为NSMutabileDictionary类型
 */
- (NSMutableDictionary *)convertDictionary;

/**
 *  将vo对象转为json格式的字符串
 *  对象中的属性类型只能是：NSString NSNumber NSArray NSDictionary NSNull 或者是本地VO实体对象
 */
- (NSString *)toJsonStr;

@end

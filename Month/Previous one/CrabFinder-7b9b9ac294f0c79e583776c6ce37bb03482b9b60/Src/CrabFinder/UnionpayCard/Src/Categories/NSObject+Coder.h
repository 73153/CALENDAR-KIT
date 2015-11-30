//
//  NSObject+Coder.h
//  OneStore
//	序列化对象的每一个属性
//  Created by towne on 14-2-20.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject(Coder)
/**
 *  功能:对象的属性序列化,对象的所有属性序列化
 *
 *  @param aCoder:序列化内容
 */
- (void)propertyEncodeWithCoder:(NSCoder *)aCoder;

/**
 *  功能:通过Coder来生成对象，对象的每一个属性
 *
 *  @param aDecoder
 *
 *  @return
 */
- (id)propertyInitWithCoder:(NSCoder *)aDecoder;
@end

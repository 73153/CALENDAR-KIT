//
//  NSObject+Coder.m
//  OneStore
//
//  Created by towne on 14-2-20.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//

#import "NSObject+Coder.h"
#import <objc/runtime.h>

@implementation NSObject(Coder)

- (void)enumeratePropertyKeyAndValueUseBlock:(void (^)(NSString *aKey, id aValue))block
{
    NSUInteger propertyCount = 0;
    objc_property_t *propertyList  = class_copyPropertyList([self class], &propertyCount);
    for(NSInteger index = 0; index < propertyCount; index++){
        objc_property_t property = propertyList[index];
        const char *pProperty = property_getName(property);
        if(pProperty == NULL){
            continue;
        }
        NSString *propertyStr = [NSString stringWithUTF8String:pProperty];
        id propertyValue = [self valueForKey:propertyStr];
        if(block){
            block(propertyStr,propertyValue);
        }
	}
    free(propertyList);
}

- (void)propertyEncodeWithCoder:(NSCoder *)aCoder
{
    [self enumeratePropertyKeyAndValueUseBlock:^(NSString *aKey, id aValue) {
         [aCoder encodeObject:aValue forKey:aKey];
    }];
}

- (id)propertyInitWithCoder:(NSCoder *)aDecoder
{
    [self enumeratePropertyKeyAndValueUseBlock:^(NSString *aKey, id aValue) {
        id value = [aDecoder decodeObjectForKey:aKey];
        if(value == nil){
            return  ;
        }
        [self setValue:value forKey:aKey];
    }];
    return self;
}
@end

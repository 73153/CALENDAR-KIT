//
//  JsonToDictionary.m
//
//  Created by towne on 14-2-23.
//  Copyright (c) 2014年 Frodo. All rights reserved.
//

#import "TDJsonToDictionary.h"

@implementation TDJsonToDictionary

+ (NSDictionary *)diccionaryFromJsonString:(NSString *)stringJson
{
    NSData *data = [stringJson dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error;
    
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                   options:0
                                                                     error:&error];
    
    if (error)
    {
        NSLog(@"Error al leer json: %@", [error description]);
    }
    
    return jsonDictionary;
}


+ (NSString *)jsonStringFromDictionary:(NSDictionary *)dictionary
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if (error)
    {
        NSLog(@"Error: %@", error);
    }
    
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                                 encoding:NSUTF8StringEncoding];
    
    return jsonString;
}

@end

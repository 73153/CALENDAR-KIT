//
//  UILabel+Attribute.h
//  OneStore
//
//  Created by towne on 14-2-19.
//  Copyright (c) 2014年 OneStore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Attribute)

- (void)AddColorText:(NSString*)actxt AColor:(UIColor*)acolor AFont:(UIFont*)afont;
- (void)appendText:(NSString *)text AColorText:(NSString*)actxt AColor:(UIColor*)acolor AFont:(UIFont*)afont;
- (void)setText:(NSString *)text AColorText:(NSString*)actxt AColor:(UIColor*)acolor AFont:(UIFont*)afont;
- (void)setText:(NSString *)text AColorTextArray:(NSArray *)actArray AColor:(UIColor*)acolor AFont:(UIFont*)afont;
@end

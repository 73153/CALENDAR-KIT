//
//  UILabel+Attribute.m
//  OneStore
//
//  Created by towne on 14-2-19.
//  Copyright (c) 2014年 OneStore. All rights reserved.
//

#import "UILabel+Attribute.h"
#import "NSArray+safe.h"

@implementation UILabel (Attribute)

- (void)AddColorText:(NSString*)actxt AColor:(UIColor*)acolor AFont:(UIFont*)afont
{
    UIFont *nfont = afont;
    if (afont == nil) {
        nfont = self.font;
    }
    NSString *text = [self attributedText].string;
    NSMutableAttributedString *nattrStr = [[NSMutableAttributedString alloc] initWithAttributedString:[self attributedText]];
    NSRange crange = [text rangeOfString:actxt];
    [nattrStr addAttribute:NSForegroundColorAttributeName value:acolor range:crange];
    [nattrStr addAttribute:NSFontAttributeName value:nfont range:crange];
    self.attributedText = nattrStr;
}

- (void)appendText:(NSString *)text AColorText:(NSString*)actxt AColor:(UIColor*)acolor AFont:(UIFont*)afont
{
    UIFont *lbfont = self.font;
    UIFont *nfont = afont;
    if (afont == nil) {
        nfont = self.font;
    }
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithAttributedString:[self attributedText]];
    NSDictionary *attrdic = [NSDictionary dictionaryWithObject:lbfont forKey:NSFontAttributeName];
    NSMutableAttributedString *nattrStr = [[NSMutableAttributedString alloc]initWithString: text attributes:attrdic];
    NSRange crange = [text rangeOfString:actxt];
    [nattrStr addAttribute:NSForegroundColorAttributeName value:acolor range:crange];
    [nattrStr addAttribute:NSFontAttributeName value:nfont range:crange];
    [attrStr appendAttributedString:nattrStr];
    self.attributedText = attrStr;
}

- (void)setText:(NSString *)text AColorText:(NSString*)actxt AColor:(UIColor*)acolor AFont:(UIFont*)afont
{
    UIFont *lbfont = self.font;
    UIFont *nfont = afont;
    if (afont == nil) {
        nfont = self.font;
    }
    NSDictionary *attrdic = [NSDictionary dictionaryWithObject:lbfont forKey:NSFontAttributeName];
    NSMutableAttributedString *nattrStr = [[NSMutableAttributedString alloc]initWithString: text attributes:attrdic];
    NSRange crange = [text rangeOfString:actxt];
    [nattrStr addAttribute:NSForegroundColorAttributeName value:acolor range:crange];
    [nattrStr addAttribute:NSFontAttributeName value:nfont range:crange];
    
    self.attributedText = nattrStr;
}

- (void)setText:(NSString *)text AColorTextArray:(NSArray *)actArray AColor:(UIColor*)acolor AFont:(UIFont*)afont
{
    UIFont *lbfont = self.font;
    UIFont *nfont = afont;
    if (afont == nil) {
        nfont = self.font;
    }
    NSDictionary *attrdic = [NSDictionary dictionaryWithObject:lbfont forKey:NSFontAttributeName];
    NSMutableAttributedString *nattrStr = [[NSMutableAttributedString alloc]initWithString: text attributes:attrdic];
    
    for (int i = 0 ; i< [actArray count]; i++) {
        NSRange crange = [text rangeOfString:[actArray safeObjectAtIndex:i]];
        [nattrStr addAttribute:NSForegroundColorAttributeName value:acolor range:crange];
        [nattrStr addAttribute:NSFontAttributeName value:nfont range:crange];
    }
  
    self.attributedText = nattrStr;
}

@end

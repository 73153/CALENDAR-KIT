//
//  UIView+Effect.h
//  MucixDown
//
//  Created by Dong Yiming on 2/24/14.
//  Copyright (c) 2014 FS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIView (Effect)

@property (nonatomic, strong) id tagObject;

-(void)applyEffectCircleSilverBorder;
-(void)applyEffectRoundRectSilverBorder;
-(void)applyEffectRoundRectShadow;
-(void)applyEffectShadowAndBorder;

-(void)applyEffectBorder;
-(void)applyEffectShadow;

-(void)removeAllGestures;

@end

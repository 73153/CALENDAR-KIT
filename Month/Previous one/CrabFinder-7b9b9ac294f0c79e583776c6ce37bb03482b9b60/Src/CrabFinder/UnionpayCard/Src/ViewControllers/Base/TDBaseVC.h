//
//  TDBaseVC.h
//  UnionpayCard
//
//  Created by Dong Yiming on 2/18/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TDBaseVC : UIViewController
@property (nonatomic, strong) UIScrollView  *scrollView;

-(void)installLogoToNavibar;
-(void)installSearchToNavibar;
-(void)installBackArrowToNavibar;
-(void)installComposeButtonToNavi;

-(void)naviToVC:(Class)aClass;

-(void)dismissAction:(id)aSender;

-(void)openImageWithURL:(NSURL *)aImageURL;

-(void)installUnderConstructionPic;

@end

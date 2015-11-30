//
//  MainViewController.h
//  playaround
//
//  Created by Yingang Xue on 7/18/14.
//  Copyright (c) 2014 Yingang Xue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CenterViewController.h"
#import "LeftPanelViewController.h"

@interface MainViewController : UIViewController <CenterViewControllerDelegate>

@property (nonatomic, strong) CenterViewController *centerViewController;
@property (nonatomic, strong) LeftPanelViewController *leftPanelViewController;

@end

//
//  CenterViewController.h
//  playaround
//
//  Created by Yingang Xue on 7/21/14.
//  Copyright (c) 2014 Yingang Xue. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CenterViewControllerDelegate <NSObject>

@optional
- (void)movePanelRight;

@required
- (void)movePanelToOriginalPosition;

@end

@interface CenterViewController : UIViewController

@property (nonatomic, assign) id<CenterViewControllerDelegate> delegate;

@end

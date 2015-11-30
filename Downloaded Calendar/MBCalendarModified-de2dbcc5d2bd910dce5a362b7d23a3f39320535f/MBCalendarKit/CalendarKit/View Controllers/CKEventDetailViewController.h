//
//  CKEventDetailViewController.h
//  MBCalendarKit
//
//  Created by Luis Fernando De Pombo on 12/31/13.
//  Copyright (c) 2013 Moshe Berman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../Core/CKCalendarEvent.h"

@protocol presentedViewControllerDelegate <NSObject>
- (void)didDismissPresentedViewController;
@end


@interface CKEventDetailViewController : UIViewController
@property CKCalendarEvent *event;
- (id)initWithNibName:(NSString *)nibNameOrNil andEvent:(CKCalendarEvent *) event bundle:(NSBundle *)nibBundleOrNil;
@end

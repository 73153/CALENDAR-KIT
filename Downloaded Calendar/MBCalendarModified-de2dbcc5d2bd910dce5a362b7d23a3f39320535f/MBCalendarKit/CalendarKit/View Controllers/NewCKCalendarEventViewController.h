//
//  CKCalendarEventViewController.h
//  MBCalendarKit
//
//  Created by Luis Fernando De Pombo on 12/3/13.
//  Copyright (c) 2013 Moshe Berman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../Core/CKCalendarEvent.h"
#import "NewCKCalendarEventView.h"


@protocol presentedViewControllerDelegate <NSObject>
- (void)didDismissPresentedViewController;
@end

@interface NewCKCalendarEventViewController : UIViewController

@property (nonatomic, weak) id<presentedViewControllerDelegate> eventDelegate;
@property CKCalendarEvent *event;
@property NSDate *eventDate;
- (id)initWithNibName:(NSString *)nibNameOrNil NSDate:(NSDate *)date bundle:(NSBundle *)nibBundleOrNil;
//- (void)viewDidDisappear:(BOOL)animated;



@end

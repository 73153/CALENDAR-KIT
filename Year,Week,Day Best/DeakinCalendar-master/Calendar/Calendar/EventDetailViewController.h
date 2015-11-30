//
//  EventDetailViewController.h
//  Calendar
//
//  Created by Peng Gao on 29/01/2015.
//  Copyright (c) 2015 Deakin University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface EventDetailViewController : UIViewController

@property (strong, nonatomic) NSManagedObject *event;

@end

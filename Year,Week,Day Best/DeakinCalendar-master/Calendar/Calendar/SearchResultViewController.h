//
//  SearchResultViewController.h
//  Calendar
//
//  Created by Peng Gao on 4/02/2015.
//  Copyright (c) 2015 Deakin University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchResultViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *events;
@end

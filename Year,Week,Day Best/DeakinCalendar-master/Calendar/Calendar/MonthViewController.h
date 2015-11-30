//
//  MonthViewController.h
//  Calendar
//
//  Created by RunliSong on 01/02/2015.
//  Copyright (c) 2015 Deakin University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MonthViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic) NSInteger year;
@property (nonatomic) NSInteger month;
@end

//
//  TDNotification.h
//  UnionpayCard
//
//  Created by Dong Yiming on 3/12/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDBaseModel.h"

typedef enum {
    kNotificationWeather = 0
    , kNotificationAttendance
    , kNotificationInventory
}ENotificationType;

@interface TDNotification : TDBaseModel
@property (nonatomic, assign)   ENotificationType       type;
@property (nonatomic, assign) long long                 userId;
@property (nonatomic, copy) NSString                    *userName;
@property (nonatomic, copy) NSString                    *userPicture;
@property (nonatomic, copy) NSString                    *userRole;
@property (nonatomic, copy) NSString                    *description;
@end

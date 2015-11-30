//
//  CKCalendarCalendarCellColors.h
//   MBCalendarKit
//
//  Created by Moshe Berman on 4/10/13.
//  Copyright (c) 2013 Moshe Berman. All rights reserved.
//

/*
 
 Defines standard colors for MBCalendarCalendarView. These were grabbed using the
 color picker in Photoshop CS6 on OS X. There's a gradient across the calendar,
 from the top down, so the colors change slightly by row.
 
 Selected Blue: #1980e5
 Normal Gray (Top Row): #e2e2e4
 Normal Gray (Bottom Row): #cccbd0
 
 Text Gradient Top Color: #2b3540
 Text Gradient Bottom Color: #495a6d
 
 */


#ifndef MBCalendarKit_CKCalendarCalendarCellColors_h
#define MBCalendarKit_CKCalendarCalendarCellColors_h

#import "NSString+Color.h"

#define kCalendarColorRed [@"#F53038" toColor]
#define kCalendarColorLightGray [@"#F8F6F8" toColor]
#define kCalendarColorDarkGray [@"#F8F8F8" toColor]

#define kCalendarColorBluishGray [@"#F0B1B1" toColor]
#define kCalendarColorTodayShadowBlue [@"#394452" toColor]
#define kCalendarColorSelectedShadowBlue [UIColor redColor]

#define kCalendarColorDarkTextGradient [@"#6D6C6D" toColor]
#define kCalendarColorLightTextGradient [@"#ffffff" toColor]

#define kCalendarColorCellBorder [@"#ffffff" toColor]
#define kCalendarColorSelectedCellBorder [@"#ffffff" toColor]

#endif

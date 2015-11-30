//
//  CircleProgressView.h
//  playaround
//
//  Created by Yingang Xue on 7/8/14.
//  Copyright (c) 2014 Yingang Xue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@class CircleProgressView;

@protocol CircularProgressViewDelegate <NSObject>

@optional

- (void)didFinishProgressing:(CircleProgressView*)cpv;

@end

@interface CircleProgressView : UIView
{
    CAShapeLayer *progressLayer;
    float progressStep;
    NSTimer *progressTimer;
    float progressDuration;
}

@property (assign, nonatomic) id <CircularProgressViewDelegate> delegate;

- (void)setLineWidth:(CGFloat)lineWidth;
- (void)startTimer;
- (void)stopTimer;

@end

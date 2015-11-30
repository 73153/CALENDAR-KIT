//
//  CircleProgressView.m
//  playaround
//
//  Created by Yingang Xue on 7/8/14.
//  Copyright (c) 2014 Yingang Xue. All rights reserved.
//

#import "CircleProgressView.h"

@implementation CircleProgressView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        progressStep = 0.0f;
        progressDuration = 1.0f;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)setLineWidth:(CGFloat)lineWidth{
    CAShapeLayer *backgroundLayer = [self createRingLayerWithCenter:CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame) / 2) radius:CGRectGetWidth(self.bounds) / 4 - lineWidth / 2 lineWidth:lineWidth color:[UIColor greenColor]];
    [self.layer addSublayer:backgroundLayer];
    progressLayer = [self createRingLayerWithCenter:CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame) / 2) radius:CGRectGetWidth(self.bounds) / 4 - lineWidth / 2 lineWidth:lineWidth color:[UIColor blueColor]];
    progressLayer.strokeEnd = 0;
    [self.layer addSublayer:progressLayer];
}

- (CAShapeLayer *)createRingLayerWithCenter:(CGPoint)center radius:(CGFloat)radius lineWidth:(CGFloat)lineWidth color:(UIColor *)color {
    UIBezierPath* smoothedPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(radius, radius) radius:radius startAngle:-M_PI_2 endAngle:(M_PI + M_PI_2) clockwise:YES];
    CAShapeLayer *slice = [CAShapeLayer layer];
    slice.contentsScale = [[UIScreen mainScreen] scale];
    slice.frame = CGRectMake(center.x-radius, center.y-radius, radius*2, radius*2);
    slice.fillColor = [UIColor clearColor].CGColor;
    slice.strokeColor = color.CGColor;
    slice.lineWidth = lineWidth;
    slice.lineCap = kCALineJoinBevel;
    slice.lineJoin = kCALineJoinBevel;
    slice.path = smoothedPath.CGPath;
    return slice;
}

- (void)setProgress:(float)progress{
    if (progress == 0) {
        progressLayer.hidden = YES;
        progressLayer.strokeEnd = 0;
    }else {
        progressLayer.hidden = NO;
        progressLayer.strokeEnd = progress;
    }
}

-(void)stepProgress
{
    if(progressStep >= 1)
    {
        [self stopTimer];
        
        if (self.delegate && [self.delegate conformsToProtocol:@protocol(CircularProgressViewDelegate)]) {
            [self.delegate didFinishProgressing:self];
        }
        
        return;
    }
    
    progressStep += progressStep;
    [self setProgress:progressStep];
    
}

-(void)startTimer
{
    [self setProgress:0];
    //定时器 2s 完成画这个圆形
    progressStep = (100/(progressDuration/0.5))/100;
    progressTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(stepProgress) userInfo:nil repeats:YES];
}

-(void)stopTimer
{
    [self setProgress:0];
    [progressTimer invalidate];
    progressTimer = nil;
}


@end

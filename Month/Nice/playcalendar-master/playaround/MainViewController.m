//
//  MainViewController.m
//  playaround
//
//  Created by Yingang Xue on 7/18/14.
//  Copyright (c) 2014 Yingang Xue. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "MainViewController.h"

#define CENTER_TAG 1
#define LEFT_PANEL_TAG 2

#define SLIDE_TIMING .25

@implementation MainViewController

@synthesize centerViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setupView
{
    centerViewController = [[CenterViewController alloc] initWithNibName:nil bundle:nil];
	centerViewController.view.tag = CENTER_TAG;
    centerViewController.delegate = self;
    [self.view addSubview:centerViewController.view];
    [self addChildViewController:centerViewController];
	[centerViewController didMoveToParentViewController:self];
}

-(void)movePanelToOriginalPosition {
	[UIView animateWithDuration:SLIDE_TIMING delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        centerViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }
                     completion:^(BOOL finished) {
                         if (finished) {
//                             [self resetMainView];
                         }
                     }];
}

@end

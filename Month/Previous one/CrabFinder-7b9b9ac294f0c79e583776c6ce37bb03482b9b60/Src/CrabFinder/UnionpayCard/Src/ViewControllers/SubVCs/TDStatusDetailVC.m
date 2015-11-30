//
//  TDStatusDetail.m
//  UnionpayCard
//
//  Created by Dong Yiming on 3/4/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDStatusDetailVC.h"

@interface TDStatusDetailVC () {
    UIImageView     *_ivPhoto;
    UILabel         *_lblName;
    UILabel         *_lblTitle;
    
    UIView          *_pictureContainer;
    NSMutableArray  *_pictureViews;
}

@end

@implementation TDStatusDetailVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Status Detail";
    _pictureViews = [NSMutableArray array];
    
    [self setupViews];
    [self setupConstraints];
}

-(void)setupViews {
    _ivPhoto = [UIImageView new];
    _ivPhoto.image = [TDImageLibrary sharedInstance].avatar;
    [self.view addSubview:_ivPhoto];
    
    _lblName = [UILabel new];
    _lblName.text = _statusUpdate.userName;
    [self.view addSubview:_lblName];
    
    _lblTitle = [UILabel new];
    _lblTitle.text = _statusUpdate.title;
    _lblTitle.numberOfLines = 0;
    _lblTitle.font = [TDFontLibrary sharedInstance].fontNormal;
    [self.view addSubview:_lblTitle];
    
    _pictureContainer = [UIView new];
    //_pictureContainer.backgroundColor = [FDColor sharedInstance].caribbeanGreen;
    [self.view addSubview:_pictureContainer];
    
    for (int i = 0; i < 4; i++) {
        UIImageView *iv = [UIImageView new];
        iv.image = [TDImageLibrary sharedInstance].farmersMarket;
        iv.userInteractionEnabled = YES;
        iv.contentMode = UIViewContentModeScaleAspectFit;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openImageWithURL:)];
        [iv addGestureRecognizer:tap];
        
#warning TODO: set tagObject with ImageURL
        iv.tagObject = @"aaaaaa";
        
        [_pictureContainer addSubview:iv];
        [_pictureViews addObject:iv];
    }
}

-(void)setupConstraints {
    [_ivPhoto alignTop:@"20" leading:@"20" toView:self.view];
    [_ivPhoto constrainWidth:@"50" height:@"50"];
    
    [_lblName constrainLeadingSpaceToView:_ivPhoto predicate:@"20"];
    [_lblName alignCenterYWithView:_ivPhoto predicate:nil];
    
    [_lblTitle alignLeading:@"20" trailing:@"-20" toView:self.view];
    [_lblTitle constrainTopSpaceToView:_ivPhoto predicate:@"20"];
    
    [_pictureContainer constrainWidth:@"200" height:@"200"];
    [_pictureContainer alignCenterXWithView:self.view predicate:nil];
    [_pictureContainer constrainTopSpaceToView:_lblTitle predicate:@"20"];
    
    UIImageView  *iv;
    for (iv in _pictureViews) {
        [iv constrainWidth:@"95" height:@"95"];
    }
    
    iv = _pictureViews[0];
    [iv alignTop:@"0" leading:@"0" toView:_pictureContainer];
    iv = _pictureViews[1];
    [iv alignTopEdgeWithView:_pictureContainer predicate:nil];
    [iv alignTrailingEdgeWithView:_pictureContainer predicate:nil];
    iv = _pictureViews[2];
    [iv alignBottomEdgeWithView:_pictureContainer predicate:nil];
    [iv alignLeadingEdgeWithView:_pictureContainer predicate:nil];
    iv = _pictureViews[3];
    [iv alignTrailingEdgeWithView:_pictureContainer predicate:nil];
    [iv alignBottomEdgeWithView:_pictureContainer predicate:nil];
}


@end

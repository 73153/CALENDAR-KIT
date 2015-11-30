//
//  TDProfileVC.m
//  UnionpayCard
//
//  Created by Dong Yiming on 2/18/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDProfileVC.h"
#import "TDLoginVC.h"
#import "UIView+Effect.h"
#import "TDStatusDetailVC.h"
#import <MWPhotoBrowser/MWPhotoBrowser.h>

#import "TDComposeReviewVC.h"
#import "TDSettingsVC.h"
#import "TDReviewCell.h"
#import "TDStatusFeedCell.h"
#import "TDReview.h"
#import "TDReviewDetailVC.h"
#import "TDProfileHeaderView.h"
#import "TDReviewsListVC.h"
#import "TDStatusListVC.h"

#define REVIEW_CELL_ID              @"TDReviewCell"
#define STATUS_CELL_ID              @"TDStatusFeedCell"
#define STATUS_CELL_HEIGHT_ID       @"TDStatusFeedCell_HEIGHT"

@interface TDProfileVC () <UITableViewDelegate, UITableViewDataSource, MWPhotoBrowserDelegate> {
    UITableView            *_tv;
    UIView                 *_headerView;
    
    UILabel                 *_lblUserName;
    UILabel                 *_lblBio;
    UIImageView             *_ivPhoto;
    
    UIScrollView            *_horizontalScrollView;
    NSLayoutConstraint      *_lastImageTrailingConstraint;
    
    NSMutableArray          *_statusArray;
    NSMutableArray          *_reviewsArray;
}

@property(nonatomic, strong)    TDStatusFeedCell		*sizingCell;
@property (nonatomic, assign) BOOL  isMyProfile;

@end

@implementation TDProfileVC

+(TDProfileVC *)newForMyProfile {
    TDProfileVC *me = [TDProfileVC new];
    me.isMyProfile = YES;
    return me;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Profile";
    
    _statusArray = [NSMutableArray array];
    
    TDStatusUpdate *status = [TDStatusUpdate new];
    status.title = @"Romulan Commander: Humans have a way of showing up when you least expect them.";
    status.userPhoto = @"https://pbs.twimg.com/profile_images/3469829141/a1a8f0bb4a721acbe33a8257842737da.jpeg";
    [_statusArray addObject:status];
    
    status = [TDStatusUpdate new];
    status.userPhoto = @"https://pbs.twimg.com/profile_images/3469829141/a1a8f0bb4a721acbe33a8257842737da.jpeg";
    status.title = @"Romulan Commander: Humans have a way of showing up when you least expect them.";
    [_statusArray addObject:status];

    
    _reviewsArray = [NSMutableArray array];
    
    TDReview *review = [TDReview new];
    review.title = @"Romulan Commander Reviewed Kirk";
    review.userPhoto = @"https://pbs.twimg.com/profile_images/3469829141/a1a8f0bb4a721acbe33a8257842737da.jpeg";
    review.content = @"Humans have a way of showing up when you least expect them.";
    review.rating = 3.5;
    [_reviewsArray addObject:review];
    
    review = [TDReview new];
    review.title = @"Romulan Commander Reviewed Kirk";
    review.userPhoto = @"https://pbs.twimg.com/profile_images/3469829141/a1a8f0bb4a721acbe33a8257842737da.jpeg";
    review.content = @"Humans have a way of showing up when you least expect them.";
    review.rating = 5;
    [_reviewsArray addObject:review];
    
    if (_isMyProfile) {
        [self installSearchToNavibar];
        
        UIBarButtonItem *btnSettings = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_gear"] style:UIBarButtonItemStylePlain target:self action:@selector(goSettings:)];
        self.navigationItem.rightBarButtonItem = btnSettings;
    }
    
    [self createSubviews];
    [self layoutSubviews];
    
}

-(void)goSettings:(id)sender {
    TDSettingsVC *vc = [TDSettingsVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)createSubviews {
    
    _tv = [UITableView new];
    _tv.delegate = self;
    _tv.dataSource = self;
    _tv.tableHeaderView = [self tableHeaderView];
    [_tv registerClass:[TDReviewCell class] forCellReuseIdentifier:REVIEW_CELL_ID];
    [_tv registerClass:[TDStatusFeedCell class] forCellReuseIdentifier:STATUS_CELL_ID];
    [_tv registerClass:[TDStatusFeedCell class] forCellReuseIdentifier:STATUS_CELL_HEIGHT_ID];
    [self.view addSubview:_tv];
    
    _sizingCell = [_tv dequeueReusableCellWithIdentifier:STATUS_CELL_HEIGHT_ID];
}

-(void)layoutSubviews {
    _tv.backgroundColor = [FDColor sharedInstance].clear;
    _tv.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tv alignToView:self.view];
}

#pragma mark -
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return _statusArray.count;
    } else {
        return _reviewsArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        
        TDStatusFeedCell *cell = [tableView dequeueReusableCellWithIdentifier:STATUS_CELL_ID forIndexPath:indexPath];
        
        TDStatusUpdate *status = _statusArray[indexPath.row];
        cell.lblTitle.text = status.title;
        [cell.ivPhoto setImageWithURL:[NSURL URLWithString:status.userPhoto] placeholderImage:SharedImage.avatar];
        return cell;
        
    } else {
        
        TDReviewCell *cell = [tableView dequeueReusableCellWithIdentifier:REVIEW_CELL_ID forIndexPath:indexPath];
        
        TDReview *review = _reviewsArray[indexPath.row];
        cell.lblTitle.text = review.title;
        cell.lblMessage.text = review.content;
        cell.viewRating.rating = review.rating;
        [cell.ivPhoto setImageWithURL:[NSURL URLWithString:review.userPhoto] placeholderImage:SharedImage.avatar];
        
        return cell;
    }
    
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        
        TDStatusUpdate *status = _statusArray[indexPath.row];
        
        _sizingCell.frame = tableView.bounds;
        
        _sizingCell.lblTitle.text = status.title;
        [_sizingCell setNeedsLayout];
        [_sizingCell layoutIfNeeded];
        CGSize size = [self.sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        return size.height + 1;
        
    }
    
    return [TDReviewCell cellHeight];
}

-(UIView *)tableHeaderView {
    
    if (_headerView) {
        return _headerView;
    }
    

    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 220)];
    
    _ivPhoto = [UIImageView new];
    _ivPhoto.image = [UIImage imageNamed:@"avatar_default"];
    [_ivPhoto applyEffectBorder];
    [_headerView addSubview:_ivPhoto];
    [_ivPhoto constrainWidth:@"50" height:@"50"];
    [_ivPhoto alignTop:@"20" leading:@"20" toView:_headerView];
    
    // label
    _lblUserName = [UILabel new];
    _lblUserName.text = @"Steve Jobs";
    _lblUserName.font = [TDFontLibrary sharedInstance].fontTitle;
    [_headerView addSubview:_lblUserName];
    //layout
    [_lblUserName constrainLeadingSpaceToView:_ivPhoto predicate:@"10"];
    [_lblUserName alignTopEdgeWithView:_ivPhoto predicate:@"0"];
    
    //
    _lblBio = [UILabel new];
    _lblBio.text = @"An American entrepreneur, marketer, and inventor, who was the co-founder, chairman, and CEO of Apple Inc.";
    _lblBio.numberOfLines = 0;
    _lblBio.font = [TDFontLibrary sharedInstance].fontNormal;
    [_headerView addSubview:_lblBio];
    
    // layout
    [_lblBio constrainTopSpaceToView:_ivPhoto predicate:@"10"];
    [_lblBio alignCenterXWithView:_headerView predicate:nil];
    [_lblBio constrainWidth:@"280"];
    
    UIView  *seperator = [UIView new];
    seperator.backgroundColor = [FDColor sharedInstance].lightGray;
    [_headerView addSubview:seperator];
    [seperator constrainHeight:@"0.5"];
    [seperator alignLeading:@"0" trailing:@"0" toView:_headerView];
    [seperator constrainTopSpaceToView:_lblBio predicate:@"15"];
    
    //
    _horizontalScrollView = [UIScrollView new];
    _horizontalScrollView.showsHorizontalScrollIndicator = NO;
    [_headerView addSubview:_horizontalScrollView];
    // layout
    [_horizontalScrollView constrainTopSpaceToView:seperator predicate:@"0"];
    [_horizontalScrollView constrainWidthToView:_headerView predicate:nil];
    [_horizontalScrollView alignCenterXWithView:_headerView predicate:nil];
    [_horizontalScrollView constrainHeight:@"80"];
    
    //
    NSMutableArray *contentViews = [NSMutableArray array];
    for (int i = 0; i < 3; i++) {
        UIImageView *ivPic = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"crab_icon"]];
        ivPic.tag = i;
        [contentViews addObject:ivPic];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapped:)];
        [ivPic addGestureRecognizer:tap];
    }
    
    UIButton  *btnMorePic = [UIButton new];
    [btnMorePic setImage:[UIImage imageNamed:@"icon_deal_arrow"] forState:UIControlStateNormal];
    [btnMorePic addTarget:self action:@selector(moreImagesTapped:) forControlEvents:UIControlEventTouchUpInside];
    [contentViews addObject:btnMorePic];
    
    [self addScrollContent:contentViews];
    
    return _headerView;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    TDProfileHeaderView *view = [TDProfileHeaderView new];

    if (section == 0) {
        view.lblTitle.text = @"Status";
        [view.btnMore addTarget:self action:@selector(viewMoreStatusAction:) forControlEvents:UIControlEventTouchUpInside];
    } else {
        view.lblTitle.text = @"Reviews";
        [view.btnMore addTarget:self action:@selector(viewMoreReviewsAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return view;
}

//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    if (section == 0) {
//        return @"Status";
//    }
//    
//    return @"Reviews";
//}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return [TDProfileHeaderView viewHeight];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        
        TDStatusUpdate *status = _statusArray[indexPath.row];
        
        TDStatusDetailVC *vc = [TDStatusDetailVC new];
        vc.statusUpdate = status;
        [self.navigationController pushViewController:vc animated:YES];
        
    } else {
        
        TDReview *review = _reviewsArray[indexPath.row];
        
        TDReviewDetailVC *vc = [TDReviewDetailVC new];
        vc.review = review;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#define IMAGE_MARGIN    (20)
#define IMAGE_SIZE      (60)
-(void)addScrollContent:(NSArray *)aContentViews {
    [_horizontalScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_horizontalScrollView removeConstraint:_lastImageTrailingConstraint];
    
    int i = 0;
    for (UIView *contentView in aContentViews) {
        contentView.userInteractionEnabled = YES;
        
        [contentView applyEffectBorder];
        [_horizontalScrollView addSubview:contentView];
        
        [contentView constrainWidth:@(IMAGE_SIZE).stringValue height:@(IMAGE_SIZE).stringValue];
        [contentView alignTopEdgeWithView:_horizontalScrollView predicate:@"10"];
        float leading = IMAGE_MARGIN * (i + 1) + IMAGE_SIZE * i;
        [contentView alignLeadingEdgeWithView:_horizontalScrollView predicate:@(leading).stringValue];
        
        if (i == aContentViews.count - 1) {
            _lastImageTrailingConstraint = [contentView alignTrailingEdgeWithView:_horizontalScrollView predicate:@(-IMAGE_MARGIN).stringValue].firstObject;
        }
        
        i++;
    }
}

-(void)imageTapped:(UITapGestureRecognizer *)sender {
    MWPhotoBrowser *vc = [[MWPhotoBrowser alloc] initWithDelegate:self];
    vc.enableGrid = NO;
    vc.startOnGrid = NO;
    [vc setCurrentPhotoIndex:sender.view.tag];
    
    vc.displayActionButton = YES;
    vc.displayNavArrows = YES;
    
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nc animated:YES completion:nil];
}

-(void)moreImagesTapped:(id)sender {
    MWPhotoBrowser *vc = [[MWPhotoBrowser alloc] initWithDelegate:self];
    vc.enableGrid = YES;
    vc.startOnGrid = YES;
    
    vc.displayActionButton = YES;
    vc.displayNavArrows = YES;
    
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nc animated:YES completion:nil];
}

#pragma mark - actions

-(void)viewMoreStatusAction:(id)sender {
    TDStatusListVC *vc = [TDStatusListVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)viewMoreReviewsAction:(id)sender {
    TDReviewsListVC *vc = [TDReviewsListVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)composeAction:(id)sender {
    TDComposeReviewVC *vc = [TDComposeReviewVC new];
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nc animated:YES completion:nil];
}

#pragma mark - MWPhotoBrowser delegate
-(NSArray *)photos {
    static NSMutableArray *photos;
    if (photos == nil) {
        photos = [NSMutableArray array];
        [photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:@"http://farm4.static.flickr.com/3567/3523321514_371d9ac42f_b.jpg"]]];
        [photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:@"http://farm4.static.flickr.com/3629/3339128908_7aecabc34b_b.jpg"]]];
        [photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:@"http://farm4.static.flickr.com/3364/3338617424_7ff836d55f_b.jpg"]]];
        [photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:@"http://farm4.static.flickr.com/3590/3329114220_5fbc5bc92b_b.jpg"]]];
        [photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:@"http://farm3.static.flickr.com/2449/4052876281_6e068ac860_b.jpg"]]];
    }
    return photos;
}

-(NSArray *)thumbs {
    
    static NSMutableArray *thumbs;
    if (thumbs == nil) {
        thumbs = [NSMutableArray array];
        [thumbs addObject:[MWPhoto photoWithURL:[NSURL URLWithString:@"http://farm4.static.flickr.com/3567/3523321514_371d9ac42f_q.jpg"]]];
        [thumbs addObject:[MWPhoto photoWithURL:[NSURL URLWithString:@"http://farm4.static.flickr.com/3629/3339128908_7aecabc34b_q.jpg"]]];
        [thumbs addObject:[MWPhoto photoWithURL:[NSURL URLWithString:@"http://farm4.static.flickr.com/3364/3338617424_7ff836d55f_q.jpg"]]];
        [thumbs addObject:[MWPhoto photoWithURL:[NSURL URLWithString:@"http://farm4.static.flickr.com/3590/3329114220_5fbc5bc92b_q.jpg"]]];
        [thumbs addObject:[MWPhoto photoWithURL:[NSURL URLWithString:@"http://farm3.static.flickr.com/2449/4052876281_6e068ac860_q.jpg"]]];
    }
    return thumbs;
}

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return [self photos].count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    return [self photos][index];
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index {
    return [self thumbs][index];
}


@end

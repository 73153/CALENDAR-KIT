//
//  TDHomeVC.m
//  UnionpayCard
//
//  Created by Dong Yiming on 2/18/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDHomeVC.h"

#import "TDStatusFeedCell.h"
#import "TDReviewCell.h"

#import "TDNewsFeed.h"
#import "TDStatusDetailVC.h"
#import "TDComposeStatusVC.h"
#import "TDReviewDetailVC.h"

#import "TDProfileVC.h"

typedef enum {
    kVcRegister = 1000
    , kVcCardList
    , kVcVendors
    , kVcAddMoney
    , kVcCredit
    , kVcConsume
    , kVcMail
    , kVcLife
}EVcType;

const NSString *strStatusCellID = @"strStatusCellID";
const NSString *strReviewCellID = @"strReviewCellID";
const NSString *strStatusCellForHeightID = @"strStatusCellForHeightID";

@interface TDHomeVC () <UITableViewDelegate, UITableViewDataSource> {

}
@property (nonatomic, strong)    UITableView            *tvFeed;
@property (nonatomic, strong)    NSMutableArray         *newsFeeds;
@property(nonatomic, strong)    TDStatusFeedCell		*sizingCell;

@end

@implementation TDHomeVC

-(NSArray *)fakeDataArray {
    NSMutableArray *arr = [NSMutableArray array];
    TDNewsFeed *feed = [TDNewsFeed new];
    feed.status = [TDStatusUpdate new];
    feed.status.userName = @"Romulan Commander";
    feed.status.userPhoto = @"https://pbs.twimg.com/profile_images/3469829141/a1a8f0bb4a721acbe33a8257842737da.jpeg";
    feed.status.title = @"Humans have a way of showing up when you least expect them.";
    [arr addObject:feed];
    
    feed = [TDNewsFeed new];
    feed.review = [TDReview new];
    feed.review.title = @"Romulan Commander Reviewed Kirk";
    feed.review.userPhoto = @"http://30a.com/wp-content/uploads/2013/08/2a5dbf935782cd137459b1a4c8a51c53.jpeg";
    feed.review.content = @"Humans have a way of showing up when you least expect them.";
    feed.review.rating = 3;
    [arr addObject:feed];
    
    feed = [TDNewsFeed new];
    feed.review = [TDReview new];
    feed.review.userPhoto = @"http://www.bestfishingrigs.com/images/Red_Drum_Wiki_4x6.jpg";
    feed.review.title = @"Romulan Commander Reviewed Kirk";
    feed.review.content = @"Humans have a way of showing up when you least expect them.";
    feed.review.rating = 5;
    [arr addObject:feed];
    
    feed = [TDNewsFeed new];
    feed.status = [TDStatusUpdate new];
    feed.status.userName = @"Spock";
    feed.status.userPhoto = @"https://pbs.twimg.com/profile_images/3469829141/a1a8f0bb4a721acbe33a8257842737da.jpeg";
    feed.status.title = @"Excuse me, there is a multi-legged creature crawling up your shoulder.";
    [arr addObject:feed];
    
    feed = [TDNewsFeed new];
    feed.status = [TDStatusUpdate new];
    feed.status.userName = @"Spock";
    feed.status.userPhoto = @"https://pbs.twimg.com/profile_images/3469829141/a1a8f0bb4a721acbe33a8257842737da.jpeg";
    feed.status.title = @"Ah, my old friend Kirk, do you know the Klingon proverb that says revenge is a dish best served cold? It is very cold in space.He tasks me. He tasks me, and I shall have him. I'll chase him 'round the moons of Nibia and 'round the Antares Maelstrom and 'round perdition's flame before I give him up!";
    [arr addObject:feed];
    
    
    feed = [TDNewsFeed new];
    feed.review = [TDReview new];
    feed.review.title = @"Romulan Commander Reviewed Kirk";
    feed.review.userPhoto = @"http://www.bestfishingrigs.com/images/Red_Drum_Wiki_4x6.jpg";
    feed.review.content = @"Humans have a way of showing up when you least expect them.";
    feed.review.rating = 2;
    [arr addObject:feed];
    
    return arr;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Newsfeed";
    _newsFeeds = [NSMutableArray array];
    [_newsFeeds addObjectsFromArray:[self fakeDataArray]];
    
    [self installSearchToNavibar];
	
    [self createSubviews];
    [self layoutSubviews];
}



-(void)createSubviews {
    
    _tvFeed = [UITableView new];
    _tvFeed.delegate = self;
    _tvFeed.dataSource = self;
    [self.view addSubview:_tvFeed];
    
    [_tvFeed registerClass:[TDStatusFeedCell class] forCellReuseIdentifier:(NSString *)strStatusCellID];
    [_tvFeed registerClass:[TDStatusFeedCell class] forCellReuseIdentifier:(NSString *)strStatusCellForHeightID];
    [_tvFeed registerClass:[TDReviewCell class] forCellReuseIdentifier:(NSString *)strReviewCellID];
    
    _sizingCell = [_tvFeed dequeueReusableCellWithIdentifier:(NSString *)strStatusCellForHeightID];
    
    __weak TDHomeVC *weakself = self;
    [_tvFeed addPullToRefreshWithActionHandler:^{
        double delayInSeconds = 1.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            
            [weakself.tvFeed.pullToRefreshView stopAnimating];
        });
    }];
    
    [_tvFeed addInfiniteScrollingWithActionHandler:^{

        double delayInSeconds = 1.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [weakself.newsFeeds addObjectsFromArray:[weakself fakeDataArray]];
            [weakself.tvFeed reloadData];
            [weakself.tvFeed.infiniteScrollingView stopAnimating];
        });
    }];
}

-(void)layoutSubviews {
    [_tvFeed alignToView:self.view];
}

#pragma mark - table view 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _newsFeeds.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    TDNewsFeed *feed = _newsFeeds[indexPath.row];
    if (feed.status) {
        TDStatusFeedCell *cell = [tableView dequeueReusableCellWithIdentifier:(NSString *)strStatusCellID forIndexPath:indexPath];
        
        cell.lblTitle.text = [feed title];
        cell.lblName.text = feed.status.userName;
        
        [cell.ivPhoto removeAllGestures];
        cell.ivPhoto.tag = indexPath.row;
        cell.ivPhoto.userInteractionEnabled = YES;
        [cell.ivPhoto setImageWithURL:[NSURL URLWithString:feed.status.userPhoto] placeholderImage:SharedImage.avatar];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goUserProfile:)];
        [cell.ivPhoto addGestureRecognizer:tap];
        
        [cell.lblName removeAllGestures];
        cell.lblName.tag = indexPath.row;
        cell.lblName.userInteractionEnabled = YES;
        tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goUserProfile:)];
        [cell.lblName addGestureRecognizer:tap];
        
        [cell setNeedsLayout];
        [cell layoutIfNeeded];
        
        return cell;
    }
    
    TDReviewCell *cell = [tableView dequeueReusableCellWithIdentifier:(NSString *)strReviewCellID forIndexPath:indexPath];
    cell.lblTitle.text = [feed title];
    cell.lblMessage.text = feed.review.content;
    cell.viewRating.rating = feed.review.rating;
    [cell.ivPhoto setImageWithURL:[NSURL URLWithString:feed.review.userPhoto] placeholderImage:SharedImage.avatar];
    
    return cell;
}

-(void)goUserProfile:(UIGestureRecognizer *)gest {
    
    TDProfileVC *vc = [TDProfileVC new];
    NSInteger row = gest.view.tag;
    TDNewsFeed *feed = _newsFeeds[row];
    vc.userID = feed.status.userID;
    [self.navigationController pushViewController:vc animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    TDNewsFeed *feed = _newsFeeds[indexPath.row];
    if (feed.status) {
        _sizingCell.frame = tableView.bounds;
        
        _sizingCell.lblTitle.text = [feed title];
        _sizingCell.lblName.text = feed.status.userName;
        [_sizingCell setNeedsLayout];
        [_sizingCell layoutIfNeeded];
        CGSize size = [self.sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        return size.height + 1;
    }
    
    return [TDReviewCell cellHeight];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TDNewsFeed *feed = _newsFeeds[indexPath.row];
    if (feed.status) {
        TDStatusDetailVC *vc = [TDStatusDetailVC new];
        vc.statusUpdate = feed.status;
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        TDReviewDetailVC *vc = [TDReviewDetailVC new];
        vc.review = feed.review;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - actions

@end

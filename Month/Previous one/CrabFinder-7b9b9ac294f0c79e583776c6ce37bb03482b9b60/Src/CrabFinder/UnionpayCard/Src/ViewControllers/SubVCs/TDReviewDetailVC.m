//
//  TDReviewDetailVC.m
//  UnionpayCard
//
//  Created by Dong Yiming on 3/4/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDReviewDetailVC.h"
#import "TDCommentCell.h"
#import "TDComposeReviewVC.h"

#define STR_CELL_ID     @"STR_CELL_ID"

/////
@interface TableHeaderView : UIView
@property (nonatomic, strong) UIImageView     *ivPhoto;
@property (nonatomic, strong) UILabel         *lblTitle;
@property (nonatomic, strong) UILabel         *lblReview;
@property (nonatomic, strong) EDStarRating    *viewRating;
@end
@implementation TableHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _lblTitle = [UILabel new];
        _lblTitle.font = [TDFontLibrary sharedInstance].fontNormalBold;
        [self addSubview:_lblTitle];
        
        _lblReview = [UILabel new];
        _lblReview.numberOfLines = 0;
        _lblReview.font = [TDFontLibrary sharedInstance].fontNormal;
        [self addSubview:_lblReview];
        
        _ivPhoto = [UIImageView new];
        _ivPhoto.image = SharedImage.avatar;
        [self addSubview:_ivPhoto];
        
        _viewRating = [TDUtil ratingViewEnabled:NO rating:3];
        [self addSubview:_viewRating];
        
        UIView *bottomLine = [UIView new];
        [self addSubview:bottomLine];
        bottomLine.backgroundColor = [FDColor sharedInstance].midnightBlue;
        [bottomLine alignLeading:@"0" trailing:@"0" toView:self];
        [bottomLine alignBottomEdgeWithView:self predicate:nil];
        [bottomLine constrainHeight:@"0.5"];
        
        
        [_lblTitle setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        [_lblReview setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        
        [_ivPhoto alignLeadingEdgeWithView:self predicate:@"10"];
        [_ivPhoto constrainWidth:@"40" height:@"40"];
        
        [_lblTitle constrainLeadingSpaceToView:_ivPhoto predicate:@"10"];
        
        [_lblReview alignLeadingEdgeWithView:_lblTitle predicate:nil];
        [_lblReview alignTrailingEdgeWithView:_lblTitle predicate:nil];
        
        [_viewRating alignLeadingEdgeWithView:_lblTitle predicate:nil];
        [_viewRating constrainWidth:@"100"];
        
        
        NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_lblTitle]-[_lblReview]-[_viewRating(20)]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_lblTitle, _lblReview, _viewRating)];
        [self addConstraints:constraints];
        
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_ivPhoto]-(>=10@500)-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_ivPhoto)];
        [self addConstraints:constraints];
    }
    return self;
}

-(void)layoutSubviews {
    CGRect bounds = self.bounds;
    _lblReview.preferredMaxLayoutWidth = bounds.size.width - (60 + 10);
    [super layoutSubviews];
}

@end
/////

@interface TDReviewDetailVC () <UITableViewDelegate, UITableViewDataSource> {
    UITableView     *_tvComments;
    
    TableHeaderView          *_headerView;
}

@end

@implementation TDReviewDetailVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Review Detail";
    
    _tvComments = [UITableView new];
    _tvComments.delegate = self;
    _tvComments.dataSource = self;
    [_tvComments registerClass:[TDCommentCell class] forCellReuseIdentifier:STR_CELL_ID];
    [self.view addSubview:_tvComments];
    [_tvComments alignToView:self.view];
    _tvComments.tableHeaderView = [self headerView];
}

#pragma mark - table view
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TDCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:STR_CELL_ID forIndexPath:indexPath];
    cell.lblTitle.text = @"User Name";
    cell.lblMessage.text = @"Comment goes here. Comment goes here. Comment goes here. Comment goes here. Comment goes here. ";
    
    [cell setNeedsLayout];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [TDCommentCell cellHeight];
}

-(UIView *)headerView {
    if (_headerView == nil) {
        _headerView = [TableHeaderView new];
        //_headerView.backgroundColor = [UIColor blueColor];
        
    }
    
    CGRect rc = self.view.bounds;
    _headerView.frame = CGRectMake(0, 0, rc.size.width, 0);
    _headerView.lblTitle.text = _review.title;
    _headerView.lblReview.text = @"Kirk Reviewed Spock: \nAh, my old friend Kirk, do you know the Klingon proverb that says revenge is a dish best served cold? It is very cold in space.He tasks me. He tasks me, and I shall have him. I'll chase him 'round the moons of Nibia and 'round the Antares Maelstrom and 'round perdition's flame before I give him up!";
    [_headerView setNeedsLayout];
    [_headerView layoutIfNeeded];
    
    CGSize size = [_headerView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    _headerView.frame = CGRectMake(0, 0, rc.size.width, size.height);
    
    return _headerView;
}




@end

//
//  TDProductDetailVC.m
//  UnionpayCard
//
//  Created by Dong Yiming on 3/15/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDProductDetailVC.h"
#import "TDProductVendorCell.h"

#define STR_CELL_ID     @"STR_CELL_ID"

const float constantUserImageSize = 60.f;

@interface TDProductDetailVC () <UITableViewDelegate, UITableViewDataSource> {
    UITableView    *_tvContent;
    UIView          *_viewTvHeader;
    
    UILabel         *_lblDesctiption;
    UIScrollView    *_svPhotosByUsers;
    NSMutableArray  *_photosByUsers;
}

@end

@implementation TDProductDetailVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Example Item";
    
    _photosByUsers = [NSMutableArray array];

    
    [self initViews];
    [self setupViews];
}

-(UIView *)tvHeader {
    if (_viewTvHeader == nil) {
        _viewTvHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 180)];
        
        _lblDesctiption = [UILabel new];
        _lblDesctiption.font = [TDFontLibrary sharedInstance].fontNormal;
        _lblDesctiption.text = @"Description of example item goes here. Description of example item goes here. Description of example item goes here. Description of example item goes here. Description of example item goes here.";
        _lblDesctiption.numberOfLines = 0;
        [_viewTvHeader addSubview:_lblDesctiption];
        
        [_lblDesctiption alignTopEdgeWithView:_viewTvHeader predicate:@"15"];
        [_lblDesctiption constrainWidth:@"300"];
        [_lblDesctiption alignLeadingEdgeWithView:_viewTvHeader predicate:@"10"];
        
        //
        _svPhotosByUsers = [UIScrollView new];
        _svPhotosByUsers.showsHorizontalScrollIndicator = NO;
        [_viewTvHeader addSubview:_svPhotosByUsers];
        
        [_svPhotosByUsers constrainTopSpaceToView:_lblDesctiption predicate:@"10"];
        [_svPhotosByUsers constrainWidthToView:_lblDesctiption predicate:nil];
        [_svPhotosByUsers alignLeadingEdgeWithView:_lblDesctiption predicate:nil];
        [_svPhotosByUsers constrainHeight:@(constantUserImageSize).stringValue];
        
        int userImageCount = 8;
        for (int i = 0; i < userImageCount; i++) {
            UIImageView *iv = [UIImageView new];
            [iv setImageWithURL:[NSURL URLWithString:SharedImage.urlVendorApple] placeholderImage:SharedImage.defaultImage];
            [_svPhotosByUsers addSubview:iv];
            [_photosByUsers addObject:iv];
            
            [iv alignTopEdgeWithView:_svPhotosByUsers predicate:@"0"];
            [iv constrainWidth:@(constantUserImageSize).stringValue height:@(constantUserImageSize).stringValue];
            
            if (i == 0) {
                [iv alignLeadingEdgeWithView:_svPhotosByUsers predicate:@"10"];
            } else if (i == userImageCount - 1) {
                [iv alignTrailingEdgeWithView:_svPhotosByUsers predicate:@"-10"];
            }
        }
        
        [UIView spaceOutViewsHorizontally:_photosByUsers predicate:@"20"];
    }
    
    return _viewTvHeader;
}

-(void)initViews {
    
    _tvContent = [UITableView new];
    _tvContent.tableHeaderView = [self tvHeader];
    _tvContent.delegate = self;
    _tvContent.dataSource = self;
    [_tvContent registerClass:[TDProductVendorCell class] forCellReuseIdentifier:STR_CELL_ID];
    [self.view addSubview:_tvContent];
}

-(void)setupViews {
    [_tvContent alignToView:self.view];
}


#pragma mark - table view
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TDProductVendorCell *cell = [tableView dequeueReusableCellWithIdentifier:STR_CELL_ID forIndexPath:indexPath];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [TDProductVendorCell cellHeight];
}

@end

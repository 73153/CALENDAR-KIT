//
//  TDBaseVC.m
//  UnionpayCard
//
//  Created by Dong Yiming on 2/18/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDBaseVC.h"
#import "TDComposeStatusVC.h"
#import "TDSearchVC.h"
#import "TDImageVC.h"

@interface TDBaseVC () {
    UIButton *_btnSearch;
    UIButton *_btnMap;
}

@end

@implementation TDBaseVC

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
    self.view.backgroundColor = [FDColor sharedInstance].silver;
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    // add logo to navigation bar
    if (self.navigationController.viewControllers.count > 1 && self == self.navigationController.topViewController) {
        [self installBackArrowToNavibar];
    }
    
    // scrollView
    _scrollView = [UIScrollView new];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    [_scrollView alignToView:self.view];


    [self installComposeButtonToNavi];
}

-(void)installUnderConstructionPic {
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *iv = [UIImageView new];
    iv.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:iv];
    [iv alignTop:@"20" leading:@"20" bottom:@"-20" trailing:@"-20" toView:self.view];
    NSURL *url = [NSURL URLWithString:@"https://lh4.googleusercontent.com/-fSoQ6lFr1J8/AAAAAAAAAAI/AAAAAAAAAAA/XvgS1JQfpWI/photo.jpg"];
    [iv setImageWithURL:url placeholderImage:nil];
}


-(void)dealloc {
    [self unobserveAllNotifications];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

-(void)installLogoToNavibar {
    UIImage *logoImg = [TDImageLibrary sharedInstance].logoName;
    UIImageView *ivLogo = [[UIImageView alloc] initWithImage:logoImg];
    float ratio = .2f;
    ivLogo.frame = CGRectMake(0, 0, logoImg.size.width * ratio, logoImg.size.height * ratio);
    UIBarButtonItem *itemLogo = [[UIBarButtonItem alloc] initWithCustomView:ivLogo];
    self.navigationItem.leftBarButtonItem = itemLogo;
}

-(UIBarButtonItem *)mapButtonItem {
    if (_btnMap == nil) {
        UIImage *mapImg = [UIImage imageNamed:@"icon_map"];
        _btnMap = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, mapImg.size.width, mapImg.size.height)];
        [_btnMap setImage:mapImg forState:UIControlStateNormal];
        [_btnMap addTarget:self action:@selector(mapAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return [[UIBarButtonItem alloc] initWithCustomView:_btnMap];
}

-(UIBarButtonItem *)searchButtonItem {
    if (_btnSearch == nil) {
        UIImage *searchImg = [UIImage imageNamed:@"icon_homepage_search"];
        _btnSearch = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, searchImg.size.width, searchImg.size.height)];
        [_btnSearch setImage:searchImg forState:UIControlStateNormal];
        [_btnSearch addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return [[UIBarButtonItem alloc] initWithCustomView:_btnSearch];
}

-(void)mapAction:(id)sender {
    
}

-(void)openImageWithURL:(id)sender {
    UITapGestureRecognizer *tap = sender;
    DLog(@"%@", tap.view.tagObject);
    TDImageVC *vc = [TDImageVC newWithURL:[NSURL URLWithString:SPONGE_BOB_URL]];
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nc animated:YES completion:nil];
}

-(void)dismissAction:(id)aSender
{
    UIViewController *vc = self.presentingViewController;
    [vc dismissViewControllerAnimated:YES completion:nil];
}

-(void)searchAction:(id)sender {
    TDSearchVC *vc = [TDSearchVC new];
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nc animated:YES completion:nil];
}

-(void)installSearchToNavibar {
    self.navigationItem.leftBarButtonItem = [self searchButtonItem];
}

-(void)installComposeButtonToNavi {
    UIBarButtonItem *btnCompose = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_compose"] style:UIBarButtonItemStylePlain target:self action:@selector(composeAction:)];
    self.navigationItem.rightBarButtonItem = btnCompose;
}

-(void)composeAction:(id)sender {
    DLog(@"composeAction:");
    TDComposeStatusVC *vc = [TDComposeStatusVC new];
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nc animated:YES completion:nil];
}

-(void)installBackArrowToNavibar {
    UIImage *backImg = [TDImageLibrary sharedInstance].btnBackArrow;
    UIButton *btnBack = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, backImg.size.width, backImg.size.height)];
    [btnBack setImage:backImg forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(naviBackAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *itemBack = [[UIBarButtonItem alloc] initWithCustomView:btnBack];
    self.navigationItem.leftBarButtonItem = itemBack;
    self.navigationItem.hidesBackButton = YES;
}

-(void)naviBackAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)naviToVC:(Class)aClass {
    if (aClass) {
        id obj = [aClass new];
        if ([obj isKindOfClass:[UIViewController class]]) {
            [self.navigationController pushViewController:(UIViewController *)obj animated:YES];
        }
    }
}

@end

//
//  TDComposeReviewVC.m
//  UnionpayCard
//
//  Created by Dong Yiming on 3/20/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDComposeReviewVC.h"

#define STR_TEXT_VIEW_PLACEHOLDER       @"Write your review here"

@interface TDComposeReviewVC () <UITextViewDelegate> {
    UIBarButtonItem     *_btnPost;
    UIBarButtonItem     *_btnCancel;
    UITextView          *_textView;
}
@property (nonatomic, strong) EDStarRating    *viewRating;

@end

@implementation TDComposeReviewVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Review";
    
    _btnPost = [[UIBarButtonItem alloc] initWithTitle:@"Post" style:UIBarButtonItemStylePlain target:self action:@selector(postAction:)];
    self.navigationItem.rightBarButtonItem = _btnPost;
    
    _btnCancel = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelAction:)];
    self.navigationItem.leftBarButtonItem = _btnCancel;
    
    [self initViews];
    [self setupViews];
}

-(void)initViews {
    
    _textView = [UITextView new];
    _textView.text = STR_TEXT_VIEW_PLACEHOLDER;
    _textView.textColor = [FDColor sharedInstance].lightGray;
    _textView.font = [TDFontLibrary sharedInstance].fontNormal;
    _textView.delegate = self;
    _textView.layer.borderWidth = 1;
    _textView.layer.borderColor = [FDColor sharedInstance].lightGray.CGColor;
    [self.view addSubview:_textView];
    
    _viewRating = [TDUtil ratingViewEnabled:YES rating:3];
    [self.view addSubview:_viewRating];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEditAction:)];
    [self.view addGestureRecognizer:tap];
}

-(void)setupViews {
    
    [_viewRating alignCenterXWithView:self.view predicate:nil];
    [_viewRating alignTopEdgeWithView:self.view predicate:@"10"];
    [_viewRating constrainWidth:@"150" height:@"20"];
    
    [_textView alignLeading:@"20" trailing:@"-20" toView:self.view];
    [_textView constrainTopSpaceToView:_viewRating predicate:@"10"];
    [_textView constrainHeight:@"150"];
    
    
}

#pragma mark - actions
-(void)endEditAction:(id)sender {
    [_textView resignFirstResponder];
}

-(void)cancelAction:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

-(void)postAction:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - text view delegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:STR_TEXT_VIEW_PLACEHOLDER]) {
        textView.text = @"";
        textView.textColor = [FDColor sharedInstance].black; //optional
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = STR_TEXT_VIEW_PLACEHOLDER;
        textView.textColor = [FDColor sharedInstance].lightGray; //optional
    }
    [textView resignFirstResponder];
}

@end

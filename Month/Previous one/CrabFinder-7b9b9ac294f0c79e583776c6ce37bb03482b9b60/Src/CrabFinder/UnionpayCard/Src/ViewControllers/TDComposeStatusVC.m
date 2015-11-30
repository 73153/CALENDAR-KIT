//
//  TDComposeStatusVC.m
//  UnionpayCard
//
//  Created by Dong Yiming on 3/17/14.
//  Copyright (c) 2014 Frodo. All rights reserved.
//

#import "TDComposeStatusVC.h"

#define STR_TEXT_VIEW_PLACEHOLDER       @"What's up?"

@interface TDComposeStatusVC () <UITextViewDelegate> {
    UIBarButtonItem     *_btnPost;
    UIBarButtonItem     *_btnCancel;
    UITextView          *_textView;
    
    UIButton            *_btnUploadImage;
}

@end

@implementation TDComposeStatusVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"New Status";
    
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
    
    _btnUploadImage = [UIButton new];
    [_btnUploadImage setImage:[UIImage imageNamed:@"btn_add_image"] forState:UIControlStateNormal];
    [self.view addSubview:_btnUploadImage];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEditAction:)];
    [self.view addGestureRecognizer:tap];
}

-(void)setupViews {
    [_textView alignLeading:@"20" trailing:@"-20" toView:self.view];
    [_textView alignTopEdgeWithView:self.view predicate:@"10"];
    [_textView constrainHeight:@"150"];
    
    [_btnUploadImage constrainTopSpaceToView:_textView predicate:@"5"];
    [_btnUploadImage alignLeadingEdgeWithView:_textView predicate:@"0"];
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

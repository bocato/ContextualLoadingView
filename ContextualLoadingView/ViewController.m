//
//  ViewController.m
//  ContextualLoadingView
//
//  Created by Eduardo Sanches Bocato on 01/03/17.
//  Copyright © 2017 bocato. All rights reserved.
//

#import "ViewController.h"
#import "LoadingView.h"

@interface ViewController ()<LoadingViewDelegate>

@property (strong, nonatomic) LoadingView *loadingView;

@property (weak, nonatomic) IBOutlet UIView *containerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureLoadingView];
}

- (void)configureLoadingView {
    self.loadingView = [LoadingView new];
    self.loadingView.frame = CGRectMake(0, 0, 320, 400);
    [self.containerView addSubview:self.loadingView];
    [self.loadingView configureForView:self.containerView];
    self.loadingView.delegate = self;
}

#pragma mark - Button Actions
- (IBAction)showLoadingViewDidTouchUpInside:(id)sender {
    [self.loadingView showWithBackground];
//    [self.loadingView show];
}

- (IBAction)hideLoadingViewDidTouchUpInside:(id)sender {
    [self.loadingView hide];
}

@end

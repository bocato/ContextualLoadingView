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
}

#pragma mark - Button Actions
- (IBAction)showLoadingViewDidTouchUpInside:(id)sender {
    [LoadingView showLoadingViewInView:self.containerView withBackgroundColor:[UIColor blackColor]];
//    [LoadingView showLoadingViewInView:self.containerView];
//    [LoadingView showLoadingViewWithBackGroundInView:self.containerView withBackgroundColor:[UIColor blackColor]];
//    [LoadingView showLoadingViewWithBackGroundInView:self.containerView];
}

- (IBAction)hideLoadingViewDidTouchUpInside:(id)sender {
    [LoadingView hideLoadingViewInView:self.containerView];
}

@end

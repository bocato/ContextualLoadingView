//
//  LoadingView.h
//  ContextualLoadingView
//
//  Created by Eduardo Sanches Bocato on 01/03/17.
//  Copyright © 2017 bocato. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LoadingView;

#pragma mark - Delegate
@protocol LoadingViewDelegate <NSObject>
@optional
- (void)showLoadingView:(LoadingView *)errorView;
- (void)hideLoadingView:(LoadingView *)errorView;
@end

@interface LoadingView : UIControl

#pragma mark - Properties
@property (strong, nonatomic) id<LoadingViewDelegate> delegate;

#pragma mark - Layout Configuration
- (void)configureForView:(UIView *)view;

#pragma mark - View Behavior
- (void)hideView;
- (void)showView;

@end

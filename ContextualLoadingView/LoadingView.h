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
@property (nonatomic, assign) BOOL showBackgroundView;

#pragma mark - Layout Configuration
- (void)configureForView:(UIView *)view;

#pragma mark - View Behavior
- (void)hide;
- (void)show;
- (void)showWithBackground;

#pragma mark - Class Methods

+ (void)showLoadingViewInView:(UIView*)view;
+ (void)showLoadingViewInView:(UIView *)view withBackgroundColor:(UIColor*)backgroundColor;
+ (void)showLoadingViewWithBackGroundInView:(UIView*)view;
+ (void)showLoadingViewWithBackGroundInView:(UIView*)view withBackgroundColor:(UIColor*)backgroundColor;
+ (void)hideLoadingViewInView:(UIView*)view;

@end

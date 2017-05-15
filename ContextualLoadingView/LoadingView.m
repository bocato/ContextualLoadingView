//
//  LoadingView.m
//  ContextualLoadingView
//
//  Created by Eduardo Sanches Bocato on 01/03/17.
//  Copyright © 2017 bocato. All rights reserved.
//

#import "LoadingView.h"
#import "Masonry.h"

static CGFloat const kBbackgroundViewAlpha = 0.9;

#pragma mark - Delegate Default Implemetation
@implementation NSObject(LoadingViewDelegate)

- (void)checkIfTheClassConformsWithLoadingViewDelegate {
    if (![self conformsToProtocol:@protocol(LoadingViewDelegate)]){
        @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:[NSString stringWithFormat:@"You must conform to protocol LoadingViewDelegate to access this method."] userInfo:nil];
    }
}

- (void)showLoadingView:(LoadingView *)loadingView {
    [self checkIfTheClassConformsWithLoadingViewDelegate];
    loadingView.showBackgroundView ? [loadingView showWithBackground] : [loadingView show];
}

- (void)hideLoadingView:(LoadingView *)loadingView {
    [self checkIfTheClassConformsWithLoadingViewDelegate];
    [loadingView hide];
}

@end


@interface LoadingView ()
#pragma mark - View Elements
@property (strong, nonatomic) UIView *backgroundView;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;
@end

@implementation LoadingView

#pragma mark - View LifeCycle
-  (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [self configureViewElements];
}

#pragma mark - Getters / Setters
- (void)setShowBackgroundView:(BOOL)showBackgroundView {
    self.backgroundView.backgroundColor = showBackgroundView ? [UIColor whiteColor] : [UIColor clearColor];
    self.backgroundView.layer.borderColor = showBackgroundView ? [[UIColor groupTableViewBackgroundColor] CGColor] : [[UIColor clearColor] CGColor];
    _showBackgroundView = showBackgroundView;
}

#pragma mark - Layout Configuration
- (void)configureActivityIndicatorBackgroundView {
    self.backgroundView = [[UIView alloc] init];
    self.backgroundView.backgroundColor = [UIColor clearColor];
    self.backgroundView.alpha = kBbackgroundViewAlpha;
    self.backgroundView.clipsToBounds = YES;
    self.backgroundView.layer.cornerRadius = 10.0;
    self.backgroundView.layer.borderColor = [[UIColor clearColor] CGColor];
    self.backgroundView.layer.borderWidth = 2.0f;
    
    UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    visualEffectView.frame = self.backgroundView.bounds;
    [self.backgroundView addSubview:visualEffectView];
    
    [self addSubview:self.backgroundView];
}

- (void)setupBackgroundViewShadow {
    self.backgroundView.layer.masksToBounds = NO;
    self.backgroundView.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.backgroundView.layer.shadowOffset = CGSizeMake(0.0, 2.0);
    self.backgroundView.layer.shadowRadius = 2.0;
    self.backgroundView.layer.shadowOpacity = 0.75;
}

- (void)configureActivityIndicator {
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicator.translatesAutoresizingMaskIntoConstraints = NO;
    self.activityIndicator.color = [UIColor lightGrayColor];
    [self.backgroundView addSubview:self.activityIndicator];
}

- (void)makeConstraints {
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(self);
        make.height.width.mas_equalTo(80);
    }];
    [self.activityIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(self.backgroundView);
        make.height.width.mas_equalTo(50);
    }];
}

- (void) configureViewElements {
    self.backgroundColor = [UIColor whiteColor];
    self.hidden = YES;
    [self configureActivityIndicatorBackgroundView];
    [self configureActivityIndicator];
    [self makeConstraints];
}

- (void)configureForView:(UIView *)view {
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.left.right.equalTo(view);
    }];
}

#pragma mark - View Behavior
- (void)hide {
    self.showBackgroundView = NO;
    self.alpha = 1.0;
    self.backgroundView.alpha = kBbackgroundViewAlpha;
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self.activityIndicator stopAnimating];
            self.backgroundView.hidden = YES;
            self.hidden = YES;
        }
    }];
}

- (void)show {
    self.showBackgroundView = NO;
    self.backgroundView.hidden = NO;
    self.backgroundView.alpha = 0.0;
    self.hidden = NO;
    self.alpha = 0.0;
    [self.activityIndicator startAnimating];
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1.0;
        self.backgroundView.alpha = kBbackgroundViewAlpha;
    }];
}

- (void)showWithBackground {
    self.showBackgroundView = YES;
    self.backgroundView.hidden = NO;
    self.backgroundView.alpha = 0.0;
    self.hidden = NO;
    self.alpha = 0.0;
    [self.activityIndicator startAnimating];
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1.0;
        self.backgroundView.alpha = kBbackgroundViewAlpha;
    }];
}

@end

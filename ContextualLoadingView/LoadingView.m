//
//  LoadingView.m
//  ContextualLoadingView
//
//  Created by Eduardo Sanches Bocato on 01/03/17.
//  Copyright © 2017 bocato. All rights reserved.
//

#import "LoadingView.h"
#import "Masonry.h"

#pragma mark - Delegate Default Implemetation
@implementation NSObject(LoadingViewDelegate)

- (void)checkIfTheClassConformsWithLoadingViewDelegate {
    if (![self conformsToProtocol:@protocol(LoadingViewDelegate)]){
        @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:[NSString stringWithFormat:@"You must conform to protocol LoadingViewDelegate to access this method."] userInfo:nil];
    }
}

- (void)showLoadingView:(LoadingView *)loadingView {
    [self checkIfTheClassConformsWithLoadingViewDelegate];
    [loadingView showView];
}

- (void)hideLoadingView:(LoadingView *)loadingView {
    [self checkIfTheClassConformsWithLoadingViewDelegate];
    [loadingView hideView];
}

@end


@interface LoadingView ()
#pragma mark - View Elements
@property (strong, nonatomic) UIView *backgroundView;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;
@end

@implementation LoadingView

#pragma mark - View LifeCycle
- (instancetype)init {
    self = [super init];
    if (self) {
        self.showBackgroundView = NO;
        [self configureViewElements];
    }
    return self;
}

- (instancetype)initWithBackgroundView {
    self = [super init];
    if (self) {
        self.showBackgroundView = YES;
        [self configureViewElements];
    }
    return self;
}


#pragma mark - Layout Configuration
- (void)configureActivityIndicatorBackgroundView {
    self.backgroundView = [[UIView alloc] init];
    self.backgroundView.backgroundColor = [UIColor lightTextColor];
    self.backgroundView.alpha = 0.99;
    self.backgroundView.clipsToBounds = YES;
    self.backgroundView.layer.cornerRadius = 10.0;
    [self addSubview:self.backgroundView];
}

- (void)setupBackgroundViewShadow {
    self.backgroundView.layer.masksToBounds = NO;
    self.backgroundView.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.backgroundView.layer.shadowOffset = CGSizeMake(0.0, 2.0);
    self.backgroundView.layer.shadowRadius = 2.0;
    self.backgroundView.layer.shadowOpacity = 0.35;
}

- (void)configureActivityIndicator {
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicator.translatesAutoresizingMaskIntoConstraints = NO;
    self.activityIndicator.color = [UIColor redColor];
    if (self.showBackgroundView) {
        [self.backgroundView addSubview:self.activityIndicator];
    }
    else {
        [self addSubview:self.activityIndicator];
    }
}

- (void)makeConstraints {
    if (self.showBackgroundView) {
        [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.mas_equalTo(self);
            make.height.width.mas_equalTo(80);
        }];
    }
    [self.activityIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
        if (self.showBackgroundView) {
            make.centerX.centerY.mas_equalTo(self.backgroundView);
        }
        else {
            make.centerX.centerY.mas_equalTo(self);
        }
        make.height.width.mas_equalTo(50);
    }];
}

- (void) configureViewElements {
    self.backgroundColor = [UIColor whiteColor];
    self.hidden = YES;
    if (self.showBackgroundView) {
        [self configureActivityIndicatorBackgroundView];
    }
    [self configureActivityIndicator];
    [self makeConstraints];
    if (self.showBackgroundView) {
        [self setupBackgroundViewShadow];
    }
}

- (void)configureForView:(UIView *)view {
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.left.right.equalTo(view);
    }];
}

#pragma mark - View Behavior
- (void)hideView {
    self.alpha = 1.0;
    if (self.showBackgroundView) {
        self.backgroundView.alpha = 0.99;
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self.activityIndicator stopAnimating];
            if (self.showBackgroundView) {
                self.backgroundView.hidden = YES;
            }
            self.hidden = YES;
        }
    }];
}

- (void)showView {
    if (self.showBackgroundView) {
        self.backgroundView.hidden = NO;
        self.backgroundView.alpha = 0.0;
    }
    self.hidden = NO;
    self.alpha = 0.0;
    [self.activityIndicator startAnimating];
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1.0;
        if (self.showBackgroundView) {
            self.backgroundView.alpha = 0.99;
        }
    }];
}

@end

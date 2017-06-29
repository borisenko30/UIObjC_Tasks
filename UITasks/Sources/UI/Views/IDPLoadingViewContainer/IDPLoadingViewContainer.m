//
//  IDPLoadingViewContainer.m
//  UITask01
//
//  Created by Student003 on 6/28/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPLoadingViewContainer.h"

#import "IDPLoadingView.h"
#import "IDPMacro.h"

static const CGFloat IDPHideAlpha = 0;
static const CGFloat IDPShowAlpha = 0.5;

@interface IDPLoadingViewContainer ()

- (IDPLoadingView *)defaultLoadingView;

- (void)showLoading;
- (void)hideLoading;

- (void)setLoading:(BOOL)loading withAlpha:(CGFloat)alpha;

@end

@implementation IDPLoadingViewContainer

@synthesize animatedLoading = _animatedLoading;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.loadingView = nil;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.loadingView = [self defaultLoadingView];
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    if (!self.loadingView) {
        self.loadingView = [self defaultLoadingView];
    }
}

#pragma mark -
#pragma mark Accessors

- (BOOL)isAnimatedLoading {
    return self.loadingView.isLoading;
}

- (void)setAnimatedLoading:(BOOL)animatedLoading {
    if (_animatedLoading != animatedLoading) {
        
        _animatedLoading = animatedLoading;
        
        if (animatedLoading) {
            [self showLoading];
            [self bringSubviewToFront:self.loadingView];
        } else {
            [self hideLoading];
        }
    }
}

- (void)setLoadingView:(IDPLoadingView *)loadingView {
    if (_loadingView != loadingView) {
        [_loadingView removeFromSuperview];
        
        _loadingView = loadingView;
        
        [self addSubview:_loadingView];
    }
}

#pragma mark -
#pragma mark Private

- (IDPLoadingView *)defaultLoadingView {
    return [IDPLoadingView loadingViewInSuperView:self];
}

- (void)showLoading {
    [self setLoading:YES withAlpha:IDPShowAlpha];
}

- (void)hideLoading {
    [self setLoading:NO withAlpha:IDPHideAlpha];
}

- (void)setLoading:(BOOL)loading withAlpha:(CGFloat)alpha {
    IDPWeakify(self);
    [self.loadingView setLoading:loading animations:^{
        IDPStrongifyAndReturnIfNil(self);
        self.loadingView.alpha = alpha;
    }];
}

@end

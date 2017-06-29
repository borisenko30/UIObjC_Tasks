//
//  IDPLoadingView.m
//  UITask01
//
//  Created by Student003 on 6/28/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPLoadingView.h"

#import "UINib+IDPExtensions.h"

static const CGFloat kIDPAnimationDuration = 1.0f;

@implementation IDPLoadingView

@synthesize loading = _loading;

#pragma mark -
#pragma mark Class Methods

+ (instancetype)loadingViewInSuperView:(UIView *)superView {
    return [[self alloc] initFromNibWithSuperView:superView];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initFromNibWithSuperView:(UIView *)superView {
    IDPLoadingView *loadingView = [UINib objectWithClass:[self class]];
    loadingView.frame = superView.bounds;
    [superView addSubview:loadingView];
    loadingView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin
                                    | UIViewAutoresizingFlexibleLeftMargin
                                    | UIViewAutoresizingFlexibleBottomMargin
                                    | UIViewAutoresizingFlexibleRightMargin;
    
    return loadingView;
}

#pragma mark -
#pragma mark Accessors

- (void)setLoading:(BOOL)loading {
    [self setLoading:loading animations:nil];
}

#pragma mark -
#pragma mark LoadingView Protocol

- (void)setLoading:(BOOL)loading
        animations:(void (^)())animations
{
    [self setLoading:loading animations:animations completionHandler:nil];
}

- (void)setLoading:(BOOL)loading
        animations:(void (^)())animations
 completionHandler:(void (^)(BOOL))completion
{
    [UIView animateWithDuration:kIDPAnimationDuration
                     animations:animations
                     completion:^(BOOL finished){
                         _loading = loading;
                         if (completion) {
                             completion(finished);
                         }
                     }];
}

@end

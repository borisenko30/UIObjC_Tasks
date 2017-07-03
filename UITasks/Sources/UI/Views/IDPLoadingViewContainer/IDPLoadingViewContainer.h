//
//  IDPLoadingViewContainer.h
//  UITask01
//
//  Created by Student003 on 6/28/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "IDPLoading.h"

@class IDPLoadingView;

@interface IDPLoadingViewContainer : UIView
@property (nonatomic, assign, getter=isLoading)   BOOL    loading;

@property (nonatomic, strong) IDPLoadingView  *loadingView;

@end

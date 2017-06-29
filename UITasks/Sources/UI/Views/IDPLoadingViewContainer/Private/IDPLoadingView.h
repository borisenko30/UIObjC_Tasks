//
//  IDPLoadingView.h
//  UITask01
//
//  Created by Student003 on 6/28/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "IDPLoading.h"

@interface IDPLoadingView : UIView <IDPLoading>
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *activityIndicator;

+ (instancetype)loadingViewInSuperView:(UIView *)superView;

@end

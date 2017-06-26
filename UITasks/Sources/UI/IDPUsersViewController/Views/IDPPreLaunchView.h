//
//  IDPPreLaunchView.h
//  UITask01
//
//  Created by Student003 on 6/21/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IDPPreLaunchView : UIView
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *activityIndicator;

- (void)startLoadingAnimation;
- (void)stopLoadingAnimation;

@end
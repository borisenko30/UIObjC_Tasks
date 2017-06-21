//
//  IDPPreLaunchUsersView.h
//  UITask01
//
//  Created by Student003 on 6/21/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IDPPreLaunchUsersView : UIView
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *activityIndicator;

- (void)modelDidBeginLoading;
- (void)modelDidLoad;

@end

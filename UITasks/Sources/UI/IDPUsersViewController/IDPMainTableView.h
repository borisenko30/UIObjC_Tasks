//
//  IDPMainTableView.h
//  UITask01
//
//  Created by Student003 on 6/19/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "IDPUsersView.h"

//#import "IDPPreLaunchView.h"
#import "IDPLoadingViewContainer.h"

#import "IDPModelObserver.h"
#import "IDPArrayModelObserver.h"

@class IDPArrayModel;

@interface IDPMainTableView : IDPLoadingViewContainer <IDPArrayModelObserver>
@property (nonatomic, strong)   IBOutlet IDPUsersView     *usersView;
//@property (nonatomic, strong)   IDPPreLaunchView          *preLaunchUsersView;
@property (nonatomic, readonly) IDPArrayModel             *usersModel;

@end

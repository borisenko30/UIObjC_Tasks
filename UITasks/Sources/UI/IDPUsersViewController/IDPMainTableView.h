//
//  IDPMainTableView.h
//  UITask01
//
//  Created by Student003 on 6/19/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "IDPLoadingViewContainer.h"

#import "IDPModelObserver.h"
#import "IDPArrayModelObserver.h"

@class IDPArrayModel;

@interface IDPMainTableView : IDPLoadingViewContainer <IDPArrayModelObserver>
@property (nonatomic, strong)   IBOutlet UITableView      *usersView;
@property (nonatomic, readonly) IDPArrayModel             *usersModel;

@end

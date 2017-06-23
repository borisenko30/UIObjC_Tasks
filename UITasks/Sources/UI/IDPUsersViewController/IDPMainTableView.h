//
//  IDPMainTableView.h
//  UITask01
//
//  Created by Student003 on 6/19/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "IDPUsersView.h"

#import "IDPPreLaunchView.h"

@class IDPUsersModel;

@protocol IDPModelObserver <NSObject>

@optional
- (void)modelDidLoad;
- (void)modelDidUnload;
- (void)modelDidFailLoading;
- (void)modelDidChange:(id)model withModificationModel:(id)modification;
- (void)modelWillLoad;

@end


@interface IDPMainTableView : UIView <IDPModelObserver>
@property (nonatomic, strong) IBOutlet IDPUsersView    *usersView;
@property (nonatomic, strong) IDPPreLaunchView    *preLaunchUsersView;

@property (nonatomic, readonly) IDPUsersModel *usersModel;


@end

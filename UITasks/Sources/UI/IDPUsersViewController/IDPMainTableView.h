//
//  IDPMainTableView.h
//  UITask01
//
//  Created by Student003 on 6/19/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "IDPUsersView.h"

#import "IDPPreLaunchUsersView.h"

@class IDPUsersModel;

@protocol IDPModelObserver <NSObject>

@optional
- (void)modelDidLoad:(id)model;
- (void)modelDidUnload:(id)model;
- (void)modelDidFailLoading:(id)model;
- (void)modelDidChange:(id)model;
- (void)modelWillLoad:(id)model;

@end


@interface IDPMainTableView : UIView <IDPModelObserver>
@property (nonatomic, strong) IBOutlet IDPUsersView    *usersView;
@property (nonatomic, strong) IDPPreLaunchUsersView    *preLaunchUsersView;

@property (nonatomic, readonly) IDPUsersModel *usersModel;


@end

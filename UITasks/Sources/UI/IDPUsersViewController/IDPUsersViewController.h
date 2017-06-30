//
//  IDPUsersViewController.h
//  UITask01
//
//  Created by Student003 on 6/14/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IDPUsersModel;

@interface IDPUsersViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) IDPUsersModel    *usersModel;

- (void)saveModel;
- (void)loadModel;

@end

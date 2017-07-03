//
//  IDPUsersView.m
//  UITask01
//
//  Created by Student003 on 6/19/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPUsersView.h"

#import "IDPUsersModel.h"

#import "IDPModificationModel.h"
#import "IDPModificationModel+UITableView.h"

#import "UINib+IDPExtensions.h"

#import "IDPMacro.h"

@implementation IDPUsersView

#pragma mark -
#pragma mark Accessors

- (void)setUsersModel:(IDPUsersModel *)usersModel {
    if (usersModel == _usersModel) {
        return;
    }
    
    [_usersModel removeObserver:self];
    
    _usersModel = usersModel;
    
    [_usersModel addObserver:self];
    [_usersModel load];
}

#pragma mark -
#pragma mark ModelObserver methods

- (void)modelWillLoad:(id)model {
    self.loading = YES;
}

- (void)modelDidLoad:(id)model {
    self.loading = NO;
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark ArrayModelObserver methods

- (void)arrayModelDidChange:(id)model withModificationModel:(id)modification {
    [modification applyToTableView:self.tableView];
}

@end

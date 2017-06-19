//
//  IDPUsersViewController.m
//  UITask01
//
//  Created by Student003 on 6/14/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPUsersViewController.h"

#import "IDPUsersView.h"
#import "IDPUser.h"
#import "IDPUserCell.h"

#import "IDPMacro.h"

#import "UINib+IDPExtensions.h"

IDPViewControllerBaseViewProperty(IDPUsersViewController, mainView, UIView)

@interface IDPUsersViewController ()

@end

#pragma mark -
#pragma mark View Lifecycle

@implementation IDPUsersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.mainView.usersView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.usersView.table.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellClass = NSStringFromClass([IDPUserCell class]);
    
    IDPUserCell *cell = [tableView dequeueReusableCellWithIdentifier:cellClass];
    if (!cell) {
        cell = [UINib objectWithClass:[IDPUserCell class]];
    }
    
    cell.user = self.mainView.usersView.table[indexPath.row];
    
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)    tableView:(UITableView *)tableView
 didEndDisplayingCell:(IDPUserCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.user = nil;
}

@end

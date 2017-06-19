//
//  IDPUsersViewController.m
//  UITask01
//
//  Created by Student003 on 6/14/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPUsersViewController.h"

#import "IDPMainTableView.h"
#import "IDPUsersView.h"
#import "IDPUser.h"
#import "IDPUserCell.h"

#import "IDPMacro.h"

#import "UINib+IDPExtensions.h"

IDPViewControllerBaseViewProperty(IDPUsersViewController, mainView, IDPMainTableView)

@interface IDPUsersViewController ()

@end

#pragma mark -
#pragma mark View Lifecycle

@implementation IDPUsersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)onTouchSort:(id)sender {
    IDPUsersView *view = self.mainView.usersView;
    [view.table sortUsers];
}

- (IBAction)onTouchAdd:(id)sender {
    IDPUsersView *view = self.mainView.usersView;
    [view.table addUser];
}

- (IBAction)onTouchEdit:(id)sender {
    IDPUsersView *view = self.mainView.usersView;
    //[view.table addUser];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.mainView.usersView.table.count;
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

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void) tableView:(UITableView *)tableView
moveRowAtIndexPath:(nonnull NSIndexPath *)sourceIndexPath
       toIndexPath:(nonnull NSIndexPath *)destinationIndexPath
{
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        IDPUsersView *view = self.mainView.usersView;
        [view.table removeUser:view.table[indexPath.row]];
    }
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

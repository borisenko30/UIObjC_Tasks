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
#import "IDPUsersModel.h"
#import "IDPUser.h"
#import "IDPUserCell.h"

#import "IDPMacro.h"

#import "UINib+IDPExtensions.h"
#import "UITableView+IDPExtensions.h"

IDPViewControllerBaseViewProperty(IDPUsersViewController, mainView, IDPMainTableView)

@interface IDPUsersViewController ()
@property (nonatomic, assign) BOOL canEdit;

@end

#pragma mark -
#pragma mark View Lifecycle

@implementation IDPUsersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [self loadModel];
    [self.mainView.usersView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)onTouchSort:(id)sender {
    IDPMainTableView *view = self.mainView;
    [view.usersModel sortUsers];
}

- (IBAction)onTouchAdd:(id)sender {
    IDPMainTableView *view = self.mainView;
    [view.usersModel addUser];
}

- (IBAction)onTouchEdit:(id)sender {
    IDPUsersView *view = self.mainView.usersView;
    self.canEdit = !self.canEdit;
    
    [view setEditing:self.canEdit animated:YES];
}

- (void)saveModel {
    [self.mainView.usersModel saveUsers];
}

- (void)loadModel {
    [self.mainView.usersModel loadUsers];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.mainView.usersModel.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IDPUserCell *cell = (IDPUserCell *)[tableView safeReusableCellWithClass:[IDPUserCell class]];
    
    cell.user = self.mainView.usersModel[indexPath.row];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.canEdit;
}

- (void) tableView:(UITableView *)tableView
moveRowAtIndexPath:(nonnull NSIndexPath *)sourceIndexPath
       toIndexPath:(nonnull NSIndexPath *)destinationIndexPath
{
    IDPUsersModel *model = self.mainView.usersModel;
    [model swapUserAtIndex:sourceIndexPath.row withUserAtIndex:destinationIndexPath.row];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        IDPMainTableView *view = self.mainView;
        [view.usersModel removeUser:view.usersModel[indexPath.row]];
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

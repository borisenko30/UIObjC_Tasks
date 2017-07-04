//
//  IDPUsersViewController.m
//  UITask01
//
//  Created by Student003 on 6/14/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPUsersViewController.h"

#import "IDPUsersView.h"
#import "IDPUsersModel.h"
#import "IDPUser.h"
#import "IDPUserCell.h"

#import "IDPMacro.h"

#import "UINib+IDPExtensions.h"
#import "UITableView+IDPExtensions.h"

IDPViewControllerBaseViewProperty(IDPUsersViewController, mainView, IDPUsersView)

@interface IDPUsersViewController ()
@property (nonatomic, assign) BOOL  canEdit;

@end

#pragma mark -
#pragma mark View Lifecycle

@implementation IDPUsersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mainView.usersModel = self.usersModel;
    
    [self loadModel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)onTouchAdd:(id)sender {
    IDPUsersView *view = self.mainView;
    [view.usersModel addObject:[IDPUser new]];
}

- (IBAction)onTouchEdit:(id)sender {
    UITableView *view = self.mainView.tableView;
    self.canEdit = !self.canEdit;
     
    [view setEditing:self.canEdit animated:YES];
}

- (void)saveModel {
    [self.mainView.usersModel save];
}

- (void)loadModel {
    [self.mainView.usersModel load];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.mainView.usersModel.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IDPUserCell *cell = (IDPUserCell *)[tableView reusableCellWithClass:[IDPUserCell class]];
    
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
    IDPArrayModel *model = self.mainView.usersModel;
    [model moveObject:model[sourceIndexPath.row] toIndex:destinationIndexPath.row];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        IDPUsersView *view = self.mainView;
        [view.usersModel removeObject:view.usersModel[indexPath.row]];
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

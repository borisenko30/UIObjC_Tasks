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

#import "IDPMacro.h"

IDPViewController(IDPUsersViewController, usersView, IDPUsersView)

@interface IDPUsersViewController ()

@end

#pragma mark -
#pragma mark View Lifecycle

@implementation IDPUsersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.usersView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * const IDPCellName = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IDPCellName];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:IDPCellName];
    }
    cell.textLabel.text = self.user.name;
    
    return cell;
}

@end

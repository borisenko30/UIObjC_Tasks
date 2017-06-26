//
//  IDPModificationModel+UITableView.m
//  UITask01
//
//  Created by Student003 on 6/26/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPModificationModel+UITableView.h"

#import "IDPInsertionModel.h"
#import "IDPDeletionModel.h"
#import "IDPMovementModel.h"

@implementation IDPModificationModel (UITableView)

- (void)applyToTableView:(UITableView *)table {
    [self applyToTableView:table section:0];
}

- (void)applyToTableView:(UITableView *)table section:(NSUInteger)section {
    [self applyToTableView:table section:section animation:UITableViewRowAnimationAutomatic];
}

- (void)applyToTableView:(UITableView *)table section:(NSUInteger)section animation:(UITableViewRowAnimation)animation {
    [self doesNotRecognizeSelector:_cmd];
}

@end

// insertion model -------------------------------------
@interface IDPInsertionModel (UITableView)

@end

@implementation IDPInsertionModel (UITableView)

- (void)applyToTableView:(UITableView *)table section:(NSUInteger)section animation:(UITableViewRowAnimation)animation {
    NSIndexPath *path = [NSIndexPath indexPathForRow:self.index inSection:section];
    
    [table insertRowsAtIndexPaths:@[path] withRowAnimation:animation];
}

@end

// deletion model -------------------------------------
@interface IDPDeletionModel (UITableView)

@end

@implementation IDPDeletionModel (UITableView)

- (void)applyToTableView:(UITableView *)table section:(NSUInteger)section animation:(UITableViewRowAnimation)animation {
    NSIndexPath *path = [NSIndexPath indexPathForRow:self.index inSection:section];
    
    [table deleteRowsAtIndexPaths:@[path] withRowAnimation:animation];
}

@end

// movement model -------------------------------------
@interface IDPMovementModel (UITableView)

@end

@implementation IDPMovementModel (UITableView)

- (void)applyToTableView:(UITableView *)table section:(NSUInteger)section animation:(UITableViewRowAnimation)animation {
    NSIndexPath *sourcePath = [NSIndexPath indexPathForRow:self.index inSection:section];
    NSIndexPath *destinationPath = [NSIndexPath indexPathForRow:self.destinationIndex inSection:section];
    
    [table moveRowAtIndexPath:sourcePath toIndexPath:destinationPath];
}

@end

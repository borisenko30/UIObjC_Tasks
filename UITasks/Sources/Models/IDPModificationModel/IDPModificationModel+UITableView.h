//
//  IDPModificationModel+UITableView.h
//  UITask01
//
//  Created by Student003 on 6/26/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPModificationModel.h"

@interface IDPModificationModel (UITableView)

// Do not call it directly. This method should be overriden in subclasses. Don't call super in overriden method.
- (void)applyToTableView:(UITableView *)table;
- (void)applyToTableView:(UITableView *)table section:(NSUInteger)section;
- (void)applyToTableView:(UITableView *)table section:(NSUInteger)section animation:(UITableViewRowAnimation)animation;

@end

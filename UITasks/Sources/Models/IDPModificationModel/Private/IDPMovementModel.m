//
//  IDPMovementModel.m
//  UITask01
//
//  Created by Student003 on 6/23/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPMovementModel.h"

@implementation IDPMovementModel

#pragma mark -
#pragma mark Accessors

- (instancetype)initWithSourceIndex:(NSUInteger)sourceIndex destinationIndex:(NSUInteger)destinationIndex; {
    self = [super init];
    self.index = index;
    
    return self;
}

#pragma mark -
#pragma mark Public

- (void)applyToTableView:(UITableView *)table {
    NSIndexPath *path = [NSIndexPath indexPathForRow:self.index inSection:0];
    
    [table insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationTop];
}

@end

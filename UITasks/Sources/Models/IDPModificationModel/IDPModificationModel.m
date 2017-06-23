//
//  IDPModificationModel.m
//  UITask01
//
//  Created by Student003 on 6/23/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPModificationModel.h"

#import "IDPInsertionModel.h"
#import "IDPDeletionModel.h"

@implementation IDPModificationModel

#pragma mark -
#pragma mark Class methods

+ (instancetype)insertionModelWithIndex:(NSUInteger)index {
    return [[IDPInsertionModel alloc] initWithIndex:index];
}

+ (instancetype)deletionModelWithIndex:(NSUInteger)index {
    return [[IDPDeletionModel alloc] initWithIndex:index];
}

#pragma mark -
#pragma mark Public

- (void)applyToTableView:(UITableView *)table {
    [self doesNotRecognizeSelector:_cmd];
}

@end

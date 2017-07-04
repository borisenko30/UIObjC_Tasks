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
#import "IDPMovementModel.h"

@interface IDPModificationModel ()
@property (nonatomic, assign) NSUInteger index;

@end

@implementation IDPModificationModel

#pragma mark -
#pragma mark Class methods

+ (instancetype)insertionModelWithIndex:(NSUInteger)index {
    return [[IDPInsertionModel alloc] initWithIndex:index];
}

+ (instancetype)deletionModelWithIndex:(NSUInteger)index {
    return [[IDPDeletionModel alloc] initWithIndex:index];
}

+ (instancetype)movementModelWithSourceIndex:(NSUInteger)sourceIndex destinationIndex:(NSUInteger)destinationIndex {
    return [[IDPMovementModel alloc] initWithSourceIndex:sourceIndex destinationIndex:destinationIndex];
}

#pragma mark -
#pragma mark Accessors

- (instancetype)initWithIndex:(NSUInteger)index {
    self = [super init];
    self.index = index;
    
    return self;
}

@end

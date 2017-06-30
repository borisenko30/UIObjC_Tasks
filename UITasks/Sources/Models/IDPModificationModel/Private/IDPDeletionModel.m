//
//  IDPDeletionModel.m
//  UITask01
//
//  Created by Student003 on 6/23/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPDeletionModel.h"

#import "IDPModificationModel+IDPExtensions.h"

@implementation IDPDeletionModel

#pragma mark -
#pragma mark Accessors

- (instancetype)initWithIndex:(NSUInteger)index {
    self = [super init];
    self.index = index;
    
    return self;
}

@end

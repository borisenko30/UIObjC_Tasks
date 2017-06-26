//
//  IDPMovementModel.m
//  UITask01
//
//  Created by Student003 on 6/23/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPMovementModel.h"

#import "IDPModificationModel+Extension.h"

@interface IDPMovementModel ()
@property (nonatomic, assign) NSUInteger destinationIndex;

@end

@implementation IDPMovementModel

#pragma mark -
#pragma mark Accessors

- (instancetype)initWithSourceIndex:(NSUInteger)sourceIndex destinationIndex:(NSUInteger)destinationIndex; {
    self = [super init];
    self.index = sourceIndex;
    self.destinationIndex = destinationIndex;
    
    return self;
}

@end

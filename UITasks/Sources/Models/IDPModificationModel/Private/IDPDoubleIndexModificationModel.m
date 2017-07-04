//
//  IDPDoubleIndexModificationModel.m
//  UITask01
//
//  Created by Student003 on 7/4/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPDoubleIndexModificationModel.h"

@interface IDPDoubleIndexModificationModel ()
@property (nonatomic, assign) NSUInteger destinationIndex;

@end

@implementation IDPDoubleIndexModificationModel

#pragma mark -
#pragma mark Accessors

- (instancetype)initWithSourceIndex:(NSUInteger)sourceIndex destinationIndex:(NSUInteger)destinationIndex; {
    self = [super initWithIndex:sourceIndex];
    self.destinationIndex = destinationIndex;
    
    return self;
}

@end

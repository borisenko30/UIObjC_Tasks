//
//  IDPDoubleIndexModificationModel.h
//  UITask01
//
//  Created by Student003 on 7/4/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPModificationModel.h"

@interface IDPDoubleIndexModificationModel : IDPModificationModel
@property (nonatomic, readonly) NSUInteger destinationIndex;

- (instancetype)initWithSourceIndex:(NSUInteger)sourceIndex destinationIndex:(NSUInteger)destinationIndex;

@end

//
//  IDPModificationModel.h
//  UITask01
//
//  Created by Student003 on 6/23/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "IDPObservableObject.h"

@interface IDPModificationModel : NSObject
@property (nonatomic, readonly) NSUInteger index;

+ (instancetype)insertionModelWithIndex:(NSUInteger)index;
+ (instancetype)deletionModelWithIndex:(NSUInteger)index;
+ (instancetype)movementModelWithSourceIndex:(NSUInteger)sourceIndex destinationIndex:(NSUInteger)destinationIndex;

@end

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
@property (nonatomic, assign) NSUInteger index;

+ (instancetype)insertionModelWithIndex:(NSUInteger)index;
+ (instancetype)deletionModelWithIndex:(NSUInteger)index;

// This method should be overriden in subclasses
- (void)applyToTableView:(UITableView *)table;

@end

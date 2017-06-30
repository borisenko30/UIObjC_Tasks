//
//  IDPModel.h
//  UITask01
//
//  Created by Student003 on 6/27/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPObservableObject.h"

typedef NS_ENUM(NSUInteger, IDPModelState) {
    IDPModelDidUnload,
    IDPModelDidLoad,
    IDPModelDidFailLoading,
    IDPModelWillLoad,
    IDPModelStateCount
};

@interface IDPModel : IDPObservableObject

- (void)load;

// should be overriden in subclasses
- (void)processLoading;

@end

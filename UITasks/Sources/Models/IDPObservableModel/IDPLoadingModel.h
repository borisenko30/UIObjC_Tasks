//
//  IDPObservableModel.h
//  UITask01
//
//  Created by Student003 on 6/27/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPObservableObject.h"

typedef NS_ENUM(NSUInteger, IDPModelState) {
    IDPModelDidLoad,
    IDPModelDidUnload,
    IDPModelDidFailLoading,
    IDPModelDidChange,
    IDPModelWillLoad
};

@interface IDPObservableModel : IDPObservableObject
//@property (nonatomic, readonly) id <NSCoding> model;

// designated initializer
//- (instancetype)initWithObject:(id <NSCoding>)object;

- (void)saveObject:(id <NSCoding>)object;
- (void)loadedObject;

@end

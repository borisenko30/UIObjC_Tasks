//
//  IDPObservationController.h
//  IDPUITask1
//
//  Created by Student004 on 6/13/17.
//  Copyright © 2017 Student004. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IDPObservableObject.h"

@interface IDPObservationController : NSObject
@property (nonatomic, readonly) id  observer;
@property (nonatomic, readonly) id  observableObject;

@property (nonatomic, readonly, getter=isValid) BOOL     valid;

+ (instancetype)observationControllerWithObserver:(id)observer
                                 observableObject:(IDPObservableObject *)observableObject;

- (instancetype)initWithObserver:(id)observer
                observableObject:(IDPObservableObject *)observableObject; //NS_DESIGNATED_INITIALIZER;

// Invalidates the object. Notification won't be passed through it and it will
// be removed from observableObject at some point.
- (void)invalidate;

@end

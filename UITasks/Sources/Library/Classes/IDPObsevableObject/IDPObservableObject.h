//
//  IDPObservableObject.h
//  IDPThirdTask
//
//  Created by Student004 on 5/25/17.
//  Copyright © 2017 Student004. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IDPBlockObservationController;

@interface IDPObservableObject : NSObject
@property (nonatomic, assign)       NSUInteger     state;

- (void)setState:(NSUInteger)state withObject:(id)object;

- (IDPBlockObservationController *)blockObservationControllerWithObserver:(id)observer;

// these methods are called in subclasses
// you should never call these methods directly from outside subclasses
- (void)notifyOfStateChange:(NSUInteger)state;
- (void)notifyOfStateChange:(NSUInteger)state withObject:(id)object;

@end

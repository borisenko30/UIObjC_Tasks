//
//  IDPBlockObservationController.h
//  IDPUITask1
//
//  Created by Student004 on 6/13/17.
//  Copyright © 2017 Student004. All rights reserved.
//

#import "IDPObservationController.h"

typedef void(^IDPStateChangeHandler)(IDPBlockObservationController *controller, id userInfo);

@interface IDPBlockObservationController : IDPObservationController

- (void)setHandler:(IDPStateChangeHandler)handler
          forState:(NSUInteger)state;

- (void)removeHandlerForState:(NSUInteger)state;

- (IDPStateChangeHandler)handlerForState:(NSUInteger)state;

- (BOOL)containsHandlerForState:(NSUInteger)state;

// states require termination with -1 or NSUIntegerMax
- (void)setHandler:(IDPStateChangeHandler)handler
         forStates:(NSUInteger)state, ...;

- (id)objectAtIndexedSubscript:(NSUInteger)index;
- (void)setObject:(id)object atIndexedSubscript:(NSUInteger)index;

@end

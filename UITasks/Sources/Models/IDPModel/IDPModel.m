//
//  IDPModel.m
//  UITask01
//
//  Created by Student003 on 6/27/17.
//  Copyright © 2017 Student003. All rights reserved.
//
#import <UIKit/UIKit.h>

#import "IDPModelObserver.h"

#import "IDPModel.h"

#import "IDPGCD.h"

@implementation IDPModel

#pragma mark -
#pragma mark Public

- (void)load {
    @synchronized (self) {
        NSUInteger state = self.state;
        
        if (IDPModelWillLoad == state || IDPModelDidLoad == state) {
            [self notifyOfState:state];
            return;
        }
        
        self.state = IDPModelWillLoad;
    }
    
    IDPDispatchAsyncInBackground(^{
        [self performLoading];
    });
}

- (void)performLoading {
    
}

#pragma mark -
#pragma mark Observable object methods

- (SEL)selectorForState:(NSUInteger)state {
    switch (state) {
        case IDPModelDidLoad:
            return @selector(modelDidLoad:);
        case IDPModelDidUnload:
            return @selector(modelDidUnload:);
        case IDPModelDidFailLoading:
            return @selector(model:didFailLoadingWithError:);
        case IDPModelWillLoad:
            return @selector(modelWillLoad:);
            
        default:
            return [super selectorForState:state];
    }
}

@end

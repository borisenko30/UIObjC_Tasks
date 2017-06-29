//
//  IDPModel.m
//  UITask01
//
//  Created by Student003 on 6/27/17.
//  Copyright © 2017 Student003. All rights reserved.
//
#import <UIKit/UIKit.h>

#import "IDPModel.h"

@implementation IDPModel

#pragma mark -
#pragma mark Public

- (void)save {
    
}

- (void)load {
    @synchronized (self) {
        if (IDPModelWillLoad == self.state) {
            [self notifyOfState:IDPModelWillLoad];
            return;
        }
        
        if (IDPModelDidLoad == self.state) {
            [self notifyOfState:IDPModelDidLoad];
            return;
        }
        
        self.state = IDPModelWillLoad;
    }
    
    [self processLoading];
}

- (void)processLoading {
    
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
            return @selector(modelDidFailLoading:);
        case IDPModelWillLoad:
            return @selector(modelWillLoad:);
            
        default:
            return [super selectorForState:state];
    }
}

@end
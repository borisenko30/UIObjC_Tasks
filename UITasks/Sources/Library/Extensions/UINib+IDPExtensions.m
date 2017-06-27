//
//  UINib+IDPExtensions.m
//  UITask01
//
//  Created by Student003 on 6/15/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "UINib+IDPExtensions.h"
#import "NSArray+IDPExtensions.h"

@implementation UINib (IDPExtensions)

+ (instancetype)nibWithClass:(Class)viewClass {
    return [self nibWithClass:viewClass bundle:nil];
}

+ (instancetype)nibWithClass:(Class)viewClass bundle:(NSBundle *)bundle {
    return [self nibWithNibName:NSStringFromClass(viewClass) bundle:bundle];
}

+ (id)objectWithClass:(Class)class {
    return [self objectWithClass:class owner:nil];
}

+ (id)objectWithClass:(Class)class owner:(id)owner {
    return [self objectWithClass:class owner:owner options:nil];
}
+ (id)objectWithClass:(Class)class owner:(id)owner options:(NSDictionary *)options {
    UINib *nib = [UINib nibWithClass:class bundle:nil];
    
    return [nib objectWithClass:class owner:owner options:options];
}

#pragma mark -
#pragma mark Public

- (id)objectWithClass:(Class)class {
    return [self objectWithClass:class owner:nil];
}

- (id)objectWithClass:(Class)class owner:(id)owner {
    return [self objectWithClass:class owner:owner options:nil];
}

- (id)objectWithClass:(Class)class owner:(id)owner options:(NSDictionary *)options {
    NSArray *objects = [self instantiateWithOwner:owner options:options];
    
    return [objects objectWithClass:class];
}

@end

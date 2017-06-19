//
//  UINib+IDPExtensions.m
//  UITask01
//
//  Created by Student003 on 6/15/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "UINib+IDPExtensions.h"

@implementation UINib (IDPExtensions)

+ (instancetype)nibWithClass:(Class)viewClass {
    return [self nibWithClass:viewClass bundle:nil];
}

+ (instancetype)nibWithClass:(Class)viewClass bundle:(NSBundle *)bundle {
    return [self nibWithNibName:NSStringFromClass(viewClass) bundle:bundle];
}

+ (id)objectWithClass:(Class)objectClass; {
    return [self objectWithClass:objectClass fromNib:[self nibWithClass:objectClass]];
}

+ (id)objectWithClass:(Class)objectClass fromNib:(UINib *)nib {
    NSArray *objects = [nib instantiateWithOwner:nil options:nil];
    
    for (id object in objects) {
        if ([object isKindOfClass:objectClass]) {
            return object;
        }
    }
    
    return nil;
}

@end

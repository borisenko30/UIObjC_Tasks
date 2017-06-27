//
//  UINib+IDPExtensions.h
//  UITask01
//
//  Created by Student003 on 6/15/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINib (IDPExtensions)

+ (instancetype)nibWithClass:(Class)viewClass;
+ (instancetype)nibWithClass:(Class)viewClass bundle:(NSBundle *)bundle;

+ (id)objectWithClass:(Class)cls;
+ (id)objectWithClass:(Class)cls owner:(id)owner;
+ (id)objectWithClass:(Class)cls owner:(id)owner options:(NSDictionary *)options;

- (id)objectWithClass:(Class)cls;
- (id)objectWithClass:(Class)cls owner:(id)owner;
- (id)objectWithClass:(Class)cls owner:(id)owner options:(NSDictionary *)options;

@end

//
//  UINib+IDPExtension.h
//  UITask01
//
//  Created by Student003 on 6/15/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINib (IDPExtension)

+ (instancetype)nibWithClass:(Class)viewClass;
+ (instancetype)nibWithClass:(Class)viewClass bundle:(NSBundle *)bundle;

+ (id)objectWithClass:(Class)objectClass;
+ (id)objectWithClass:(Class)objectClass fromNib:(UINib *)nib;

@end

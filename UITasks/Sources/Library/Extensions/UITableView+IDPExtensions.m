
//
//  UITableView+IDPExtensions.m
//  UITask01
//
//  Created by Student003 on 6/20/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "UITableView+IDPExtensions.h"

#import "UINib+IDPExtensions.h"

@implementation UITableView (IDPExtensions)

- (UITableViewCell *)reusableCellWithClass:(Class)cellClass {
    return [self dequeueReusableCellWithIdentifier:NSStringFromClass(cellClass)];
}

- (UITableViewCell *)safeReusableCellWithClass:(Class)cellClass {
    id cell = [self reusableCellWithClass:cellClass];
    
    if (!cell) {
        cell = [UINib objectWithClass:cellClass];
    }
    
    return cell;
}

@end

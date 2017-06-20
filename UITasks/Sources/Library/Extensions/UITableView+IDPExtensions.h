//
//  UITableView+IDPExtensions.h
//  UITask01
//
//  Created by Student003 on 6/20/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (IDPExtensions)

- (UITableViewCell *)reusableCellWithClass:(Class)cellClass;
- (UITableViewCell *)safeReusableCellWithClass:(Class)cellClass;

@end

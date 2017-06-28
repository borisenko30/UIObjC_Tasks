//
//  IDPArrayModelProtocol.h
//  UITask01
//
//  Created by Student003 on 6/28/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IDPArrayModelObserver <IDPModelObserver>

@optional
- (void)arrayModelDidChange:(id)model withModificationModel:(id)modification;

@end

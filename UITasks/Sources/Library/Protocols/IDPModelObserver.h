//
//  IDPModelObserver.h
//  UITask01
//
//  Created by Student003 on 6/27/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IDPModelObserver <NSObject>

@optional
- (void)modelDidLoad;
- (void)modelDidUnload;
- (void)modelDidFailLoading;
- (void)modelDidChange:(id)model withModificationModel:(id)modification;
- (void)modelWillLoad;

@end

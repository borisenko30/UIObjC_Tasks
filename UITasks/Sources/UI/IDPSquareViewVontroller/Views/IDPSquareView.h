//
//  IDPSquareView.h
//  UITask01
//
//  Created by Student003 on 6/12/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "IDPSquare.h"

typedef void(^IDPCompletionHandler)(BOOL finished);

@interface IDPSquareView : UIView
@property (nonatomic, assign) BOOL running;

- (IDPSquarePosition)squarePosition;

- (void)setSquarePosition:(IDPSquarePosition)position;
- (void)setSquarePosition:(IDPSquarePosition)position animated:(BOOL)animated;
- (void)setSquarePosition:(IDPSquarePosition)position
                 animated:(BOOL)animated
        completionHandler:(IDPCompletionHandler)handler;

- (IDPSquarePosition)nextPosition;

- (void)moveSquareToNextPosition;

@end

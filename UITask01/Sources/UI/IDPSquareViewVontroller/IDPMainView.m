//
//  IDPMainView.m
//  UITask01
//
//  Created by Student003 on 6/12/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPMainView.h"
#import "IDPSquareView.h"
#import "IDPSquare.h"

static const CGFloat IDPAnimationDuration = 2.0f;

typedef void(^IDPCompletionHandler)(BOOL finished);

@interface IDPMainView ()
@property (nonatomic, strong) IDPSquare *square;

- (void)moveSquareToPosition:(IDPSquarePosition)position;
- (void)moveSquareToPosition:(IDPSquarePosition)position animated:(BOOL)animated;
- (void)moveSquareToPosition:(IDPSquarePosition)position
                    animated:(BOOL)animated
           completionHandler:(IDPCompletionHandler)handler;

- (void)moveSquare;

- (void)start;
- (void)stop;

- (IDPSquarePosition)nextPosition;

- (CGPoint)pointWithPosition:(IDPSquarePosition)position;

@end

@implementation IDPMainView

#pragma mark -
#pragma mark Accessors

- (void)setRunning:(BOOL)running {
    if (running == _running) {
        return;
    }
    
    _running = running;
    
    if (running) {
        [self start];
    } 
}

#pragma mark -
#pragma mark UIView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.square = [IDPSquare new];
}

#pragma mark -
#pragma mark Private

- (void)moveSquareToPosition:(IDPSquarePosition)position {
    [self moveSquareToPosition:position animated:NO completionHandler:nil];
}
- (void)moveSquareToPosition:(IDPSquarePosition)position animated:(BOOL)animated {
    [self moveSquareToPosition:position animated:animated completionHandler:nil];
}

- (void)moveSquareToPosition:(IDPSquarePosition)position
                    animated:(BOOL)animated
           completionHandler:(IDPCompletionHandler)handler
{
    IDPSquareView *square = self.squareView;
    
    CGPoint point = [self pointWithPosition:position];
    CGFloat duration = animated ? IDPAnimationDuration : 0;
    
    [UIView animateWithDuration:duration
                     animations:^{
                         square.center = point;
                     }
                     completion:handler];
}

- (void)moveSquare {
    __block IDPSquarePosition position = [self nextPosition];
  
    __weak IDPMainView *weakSelf = self;
    
    [self moveSquareToPosition:position animated:YES completionHandler:^(BOOL finished) {
        if (!weakSelf.running) {
            return;
        }
  
        weakSelf.square.position = position;
        [weakSelf moveSquare];
    }];
}

- (void)start {
    [self moveSquare];
}

- (void)stop {

}

- (IDPSquarePosition)nextPosition {
    IDPSquare *square = self.square;
    
    if (square.position == IDPLeftBottom) {
        return IDPLeftTop;
    } else {
        return square.position + 1;
    }
}

- (CGPoint)pointWithPosition:(IDPSquarePosition)position {
    CGRect frame = self.frame;
    IDPSquareView *square = self.squareView;
    
    CGPoint point;
    CGFloat centerDistance = square.frame.size.width / 2;
    CGFloat leftX = centerDistance;
    CGFloat rightX = frame.size.width - centerDistance;
    CGFloat topY = centerDistance;
    CGFloat bottomY = frame.size.height - centerDistance;    
    
    switch(position) {
        case IDPLeftTop:
            point = CGPointMake(leftX, topY);
            break;
        case IDPRightTop:
            point = CGPointMake(rightX, topY);
            break;
        case IDPLeftBottom:
            point = CGPointMake(leftX, bottomY);
            break;
        case IDPRightBottom:
            point = CGPointMake(rightX, bottomY);
            break;
            
        default:
            point = CGPointMake(0, 0);
            break;
    }
    
    return point;
}

@end

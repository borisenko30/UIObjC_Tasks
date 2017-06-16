//
//  IDPSquareView.m
//  UITask01
//
//  Created by Student003 on 6/12/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPSquareView.h"
#import "IDPSquare.h"

static const CGFloat IDPAnimationDuration = 2.0f;

typedef void(^IDPCompletionHandler)(BOOL finished);

@interface IDPSquareView ()
@property (nonatomic, strong) IDPSquare *square;

- (void)moveSquareToPosition:(IDPSquarePosition)position;
- (void)moveSquareToPosition:(IDPSquarePosition)position animated:(BOOL)animated;
- (void)moveSquareToPosition:(IDPSquarePosition)position
                    animated:(BOOL)animated
           completionHandler:(IDPCompletionHandler)handler;

- (void)moveSquare;

- (IDPSquarePosition)nextPosition;

- (CGPoint)pointWithPosition:(IDPSquarePosition)position;

@end

@implementation IDPSquareView

#pragma mark -
#pragma mark Accessors

- (void)setRunning:(BOOL)running {
    if (running == _running) {
        return;
    }
    
    _running = running;
    
    if (running) {
        [self moveSquare];
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
    __weak IDPSquareView *weakSelf = self;
    [UIView animateWithDuration:animated ? IDPAnimationDuration : 0
                     animations:^{
                         weakSelf.center = [weakSelf pointWithPosition:position];
                     }
                     completion:handler];
}

- (void)moveSquare {
    __block IDPSquarePosition position = [self nextPosition];
    
    __weak IDPSquareView *weakSelf = self;
    
    [self moveSquareToPosition:position animated:YES completionHandler:^(BOOL finished) {
        if (!weakSelf.running) {
            return;
        }
        
        weakSelf.square.position = position;
        [weakSelf moveSquare];
    }];
}

- (IDPSquarePosition)nextPosition {
    IDPSquare *square = self.square;
    return (square.position + 1) % IDPSquarePositionCount;
}

- (CGPoint)pointWithPosition:(IDPSquarePosition)position {
    CGRect frame = self.frame;
    CGRect superViewFrame = [self.superview convertRect:self.superview.bounds toView:nil];
    
    CGFloat squareMidWidth = CGRectGetWidth(frame) / 2;
    CGFloat squareMidHeight = CGRectGetHeight(frame) / 2;  
    
    CGPoint point = CGPointMake(squareMidWidth, squareMidHeight);
    CGPoint bottomRight = CGPointMake(CGRectGetWidth(superViewFrame) - squareMidWidth,
                                      CGRectGetHeight(superViewFrame) - squareMidHeight);
    
    switch(position) {
            
        case IDPRightTop:
            point.x = bottomRight.x;
            break;
            
        case IDPLeftBottom:
            point.y = bottomRight.y;
            break;
            
        case IDPRightBottom:
            point = bottomRight;
            break;
            
        default:
            break;
    }
    
    return point;
}

@end

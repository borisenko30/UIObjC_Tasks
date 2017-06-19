//
//  IDPSquareView.m
//  UITask01
//
//  Created by Student003 on 6/12/17.
//  Copyright © 2017 Student003. All rights reserved.
//

#import "IDPSquareView.h"
#import "IDPSquare.h"

#import "IDPMacro.h"

static const CGFloat IDPAnimationDuration = 2.0f;

@interface IDPSquareView ()
@property (nonatomic, strong) IDPSquare *square;

- (void)moveSquareInLoop;
- (CGPoint)centerPointWithPosition:(IDPSquarePosition)position;

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
        [self moveSquareInLoop];
    }
}

- (IDPSquarePosition)squarePosition {
    return self.square.position;
}

#pragma mark -
#pragma mark UIView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.square = [IDPSquare new];
}

#pragma mark -
#pragma mark Public

- (void)setSquarePosition:(IDPSquarePosition)position {
    [self setSquarePosition:position animated:NO completionHandler:nil];
}
- (void)setSquarePosition:(IDPSquarePosition)position animated:(BOOL)animated {
    [self setSquarePosition:position animated:animated completionHandler:nil];
}

- (void)setSquarePosition:(IDPSquarePosition)position
                 animated:(BOOL)animated
        completionHandler:(IDPCompletionHandler)handler
{
    IDPWeakify(self)
    [UIView animateWithDuration:animated ? IDPAnimationDuration : 0
                     animations:^{
                         IDPStrongify(self)
                         self.center = [self centerPointWithPosition:position];
                     }
                     completion:^(BOOL finished){
                         IDPStrongify(self)
                         self.square.position = position;
                         
                         if (handler) {
                             handler(finished);
                         }
                     }];
}

- (IDPSquarePosition)nextPosition {
    return [self.square nextPosition];
}

#pragma mark -
#pragma mark Private

- (void)moveSquareInLoop {
    __block IDPSquarePosition position = [self nextPosition];
    
    IDPWeakify(self)
    [self setSquarePosition:position animated:YES completionHandler:^(BOOL finished) {
        IDPStrongify(self)
        if (!self.running) {
            return;
        }
        
        [self moveSquareInLoop];
    }];
}

- (CGPoint)centerPointWithPosition:(IDPSquarePosition)position {
    CGRect bounds = self.bounds;
    CGRect superViewBounds = [self.superview convertRect:self.superview.bounds toView:nil];
    
    CGFloat squareMidWidth = CGRectGetMidX(bounds);
    CGFloat squareMidHeight = CGRectGetMidY(bounds);
    
    CGPoint point = CGPointMake(squareMidWidth, squareMidHeight);
    CGPoint bottomRight = CGPointMake(CGRectGetWidth(superViewBounds) - squareMidWidth,
                                      CGRectGetHeight(superViewBounds) - squareMidHeight);
    
    switch(position) {
            
        case IDPSquarePositionRightTop:
            point.x = bottomRight.x;
            break;
            
        case IDPSquarePositionLeftBottom:
            point.y = bottomRight.y;
            break;
            
        case IDPSquarePositionRightBottom:
            point = bottomRight;
            break;
            
        default:
            break;
    }
    
    return point;
}

@end

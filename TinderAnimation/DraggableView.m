//
//  DraggableView.m
//  TinderAnimation
//
//  Created by Da-Tou on 09/03/2017.
//  Copyright © 2017 Da-Tou. All rights reserved.
//

#import "DraggableView.h"


#define ACTION_MARGIN 120 //distance from center where the action applies. Higher = swipe further in order for the action to be called
#define SCALE_STRENGTH 4 //how quickly the card shrinks. Higher = slower shrinking
#define SCALE_MAX .93 //upper bar for how much the card shrinks. Higher = shrinks less
#define ROTATION_MAX 1 //the maximum rotation allowed in radians.  Higher = card can keep rotating longer
#define ROTATION_STRENGTH 320 //strength of rotation. Higher = weaker rotation
#define ROTATION_ANGLE M_PI/8 //Higher = stronger rotation angle

@implementation DraggableView {
    CGFloat xFromCenter;
    CGFloat yFromCenter;
}

@synthesize panGestureRecognizer;
@synthesize information;
@synthesize overlayView;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
        
        panGestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(beingDragged:)];
        
        [self addGestureRecognizer:panGestureRecognizer];
        [self addSubview:information];
        
        overlayView = [[OverlayView alloc]initWithFrame:CGRectMake(self.frame.size.width/2-100, 0, 100, 100)];
        overlayView.alpha = 0;
        [self addSubview:overlayView];
    }
    return self;
}

- (void)setupView
{
    self.layer.cornerRadius = 4;
    self.layer.shadowRadius = 3;
    self.layer.shadowOpacity = 0.2;
    self.layer.shadowOffset = CGSizeMake(1, 1);
}

- (void)beingDragged:(UIPanGestureRecognizer *)gestureRecognizer {
    xFromCenter = [gestureRecognizer translationInView:self].x; //positive for right swipe, negative for left
    yFromCenter = [gestureRecognizer translationInView:self].y; //positive for up, negative for down
    
    switch (gestureRecognizer.state) {
            
            case UIGestureRecognizerStateBegan:{
                self.originalPoint = self.center;
                break;
            };
            case UIGestureRecognizerStateChanged:{
                CGFloat rotationStrength = MIN(xFromCenter / ROTATION_STRENGTH, ROTATION_MAX);
                CGFloat rotationAngel = (CGFloat) (ROTATION_ANGLE * rotationStrength);
                CGFloat scale = MAX(1 - fabs(rotationStrength) / SCALE_STRENGTH, SCALE_MAX);
                
                self.center = CGPointMake(self.originalPoint.x + xFromCenter, self.originalPoint.y + yFromCenter);
                CGAffineTransform transform = CGAffineTransformMakeRotation(rotationAngel);
                CGAffineTransform scaleTransform = CGAffineTransformScale(transform, scale, scale);
                
                self.transform = scaleTransform;
                [self updateOverlay:xFromCenter];
                
                break;
            };
            //%%% let go of the card
            case UIGestureRecognizerStateEnded: {
                [self afterSwipeAction];
                break;
            };
            case UIGestureRecognizerStatePossible:break;
            case UIGestureRecognizerStateCancelled:break;
            case UIGestureRecognizerStateFailed:break;
    }
}

- (void)updateOverlay:(CGFloat)distance
{
    if (distance > 0) {
        overlayView.mode = overlayViewModeRight;
    } else {
        overlayView.mode = overlayViewModeLeft;
    }
    
    overlayView.alpha = MIN(fabs(distance)/100, 0.4);
}

- (void)afterSwipeAction
{
    if (xFromCenter > ACTION_MARGIN) {
        [self rightAction];
    } else if (xFromCenter < -ACTION_MARGIN) {
        [self leftAction];
    } else {
        [UIView animateWithDuration:0.3
                         animations:^{
                             self.center = self.originalPoint;
                             self.transform = CGAffineTransformMakeRotation(0);
                             overlayView.alpha = 0;
                         }];
    }
}

- (void)rightAction {
    CGPoint finishPoint = CGPointMake(500, 2*yFromCenter +self.originalPoint.y);
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.center = finishPoint;
                     }completion:^(BOOL complete){
                         [self removeFromSuperview];
                     }];
    
    NSLog(@"YES");
}

- (void)leftAction {
    CGPoint finishPoint = CGPointMake(-500, 2*yFromCenter +self.originalPoint.y);
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.center = finishPoint;
                     }completion:^(BOOL complete){
                         [self removeFromSuperview];
                     }];
    
    NSLog(@"NO");
}

- (void)rightClickAction {
    CGPoint finishPoint = CGPointMake(600, self.center.y);
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.center = finishPoint;
                         self.transform = CGAffineTransformMakeRotation(1);
                     }completion:^(BOOL complete){
                         [self removeFromSuperview];
                     }];
    NSLog(@"YES");
}

- (void)leftClickAction {
    CGPoint finishPoint = CGPointMake(-600, self.center.y);
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.center = finishPoint;
                         self.transform = CGAffineTransformMakeRotation(-1);
                     }completion:^(BOOL complete){
                         [self removeFromSuperview];
                     }];
    
    NSLog(@"NO");
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

//
//  DraggableView.h
//  TinderAnimation
//
//  Created by Da-Tou on 09/03/2017.
//  Copyright © 2017 Da-Tou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "overlayView.h"

@interface DraggableView : UIView

@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic) CGPoint originalPoint;
@property (nonatomic,strong) OverlayView* overlayView;
@property (nonatomic,strong) UILabel* information;

@end
//
//  overlayView.h
//  TinderAnimation
//
//  Created by Da-Tou on 09/03/2017.
//  Copyright © 2017 Da-Tou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger , OverlayViewMode) {
    overlayViewModeLeft,
    overlayViewModeRight
};

@interface OverlayView : UIView

@property (nonatomic) OverlayViewMode mode;
@property (nonatomic, strong) UIImageView *imageView;

@end

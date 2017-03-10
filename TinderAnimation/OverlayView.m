//
//  overlayView.m
//  TinderAnimation
//
//  Created by Da-Tou on 09/03/2017.
//  Copyright © 2017 Da-Tou. All rights reserved.
//

#import "overlayView.h"

@implementation OverlayView

@synthesize imageView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"noButton"]];
        [self addSubview:imageView];
    }
    return self;
}

- (void)setMode:(OverlayViewMode)mode
{
    if (_mode == mode) {
        return;
    }
    
    _mode = mode;
    
    if(mode == overlayViewModeLeft) {
        imageView.image = [UIImage imageNamed:@"noButton"];
    } else {
        imageView.image = [UIImage imageNamed:@"yesButton"];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    imageView.frame = CGRectMake(50, 50, 100, 100);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

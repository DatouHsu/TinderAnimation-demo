//
//  DraggableViewBackground.h
//  TinderStyle-demo
//
//  Created by Da-Tou on 09/03/2017.
//  Copyright © 2017 Da-Tou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DraggableViewBackground : UIView

@property (retain, nonatomic) NSArray *exampleCardLabel;
@property (retain, nonatomic) NSMutableArray *allCards;

- (void)cardSwipeLeft:(UIView *)card;
- (void)cardSwipeRight:(UIView *)card;

@end

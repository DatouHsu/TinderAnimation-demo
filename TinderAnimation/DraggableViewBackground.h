//
//  DraggableViewBackground.h
//  TinderStyle-demo
//
//  Created by Da-Tou on 09/03/2017.
//  Copyright © 2017 Da-Tou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DraggableView.h"

@interface DraggableViewBackground : UIView <DraggableViewDelegate>

@property (retain, nonatomic) NSArray *exampleCardLabel;
@property (retain, nonatomic) NSMutableArray *allCards;

- (void)cardSwipe:(UIView *)card;

@end

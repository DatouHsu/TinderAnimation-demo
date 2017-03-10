//
//  DraggableViewBackground.m
//  TinderStyle-demo
//
//  Created by Da-Tou on 09/03/2017.
//  Copyright © 2017 Da-Tou. All rights reserved.
//

#import "DraggableViewBackground.h"
#import "DraggableView.h"

@implementation DraggableViewBackground {
    NSInteger cardsLoadedIndex;
    NSMutableArray *loadedCards;
    
    UIButton *menuButton;
    UIButton *messageButton;
    UIButton *checkButton;
    UIButton *xButton;
}

static const int MAX_BUFFER_SIZE = 2;
static const float CARD_HEIGHT = 386;
static const float CARD_WIDTH = 290;

//@synthesize exampleCardLabels;
@synthesize allCards;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [super layoutSubviews];
        [self setupView];
        _exampleCardLabel = [[NSArray alloc]initWithObjects:@"first",@"second",@"third",@"fourth",@"last", nil];
        loadedCards = [[NSMutableArray alloc] init];
        allCards = [[NSMutableArray alloc] init];
        cardsLoadedIndex = 0;
        [self loadCards];
    }
    return self;
}

- (void)setupView {
    self.backgroundColor = [UIColor colorWithRed:.92 green:.93 blue:.95 alpha:1];
    menuButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 34, 30, 20)];
    [menuButton setImage:[UIImage imageNamed:@"menuButton"] forState:UIControlStateNormal];
    messageButton = [[UIButton alloc]initWithFrame:CGRectMake(320, 34, 28, 18)];
    [messageButton setImage:[UIImage imageNamed:@"messageButton"] forState:UIControlStateNormal];
    xButton = [[UIButton alloc]initWithFrame:CGRectMake(80, 545, 59, 59)];
    [xButton setImage:[UIImage imageNamed:@"xButton"] forState:UIControlStateNormal];
    [xButton addTarget:self action:@selector(swipeToLeft) forControlEvents:UIControlEventTouchUpInside];
    checkButton = [[UIButton alloc]initWithFrame:CGRectMake(220, 545, 59, 59)];
    [checkButton setImage:[UIImage imageNamed:@"checkButton"] forState:UIControlStateNormal];
    [checkButton addTarget:self action:@selector(swipeToRight) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:menuButton];
    [self addSubview:messageButton];
    [self addSubview:xButton];
    [self addSubview:checkButton];
}

- (void)loadCards {
    if ([_exampleCardLabel count] > 0) {
        NSInteger numLoadedCardsCap = (([_exampleCardLabel count] > MAX_BUFFER_SIZE)? MAX_BUFFER_SIZE : [_exampleCardLabel count]);
        
        for (int i = 0; i < [_exampleCardLabel count]; i++) {
            DraggableView *newCard = [self createDraggableViewWithDataAtIndex:i];
            [allCards addObject:newCard];
            
            if (i < numLoadedCardsCap) {
                [loadedCards addObject:newCard];
            }
        }
        
        for (int i = 0; i < [loadedCards count]; i++) {
            if (i > 0) {
                [self insertSubview:[loadedCards objectAtIndex:i] belowSubview:[loadedCards objectAtIndex:i-1]];
            } else {
                [self addSubview:[loadedCards objectAtIndex:i]];
            }
            cardsLoadedIndex++;
        }
    }
}

- (DraggableView *)createDraggableViewWithDataAtIndex: (NSInteger) index {
    
    DraggableView *draggableView = [[DraggableView alloc]initWithFrame:CGRectMake((self.frame.size.width - CARD_WIDTH)/2, (self.frame.size.height - CARD_HEIGHT)/2, CARD_WIDTH, CARD_HEIGHT)];
    draggableView.backgroundColor = [UIColor lightGrayColor];
    draggableView.information.text = [_exampleCardLabel objectAtIndex:index];
    draggableView.delegate = self;
    return draggableView;
}

- (void)cardSwiped:(UIView *)card {
    [loadedCards removeObjectAtIndex:0]; //card was swiped, so it's no longer a "loaded card"
    
    if (cardsLoadedIndex < [allCards count]) { //if we haven't reached the end of all cards, put another into the loaded cards
        [loadedCards addObject:[allCards objectAtIndex:cardsLoadedIndex]];
        cardsLoadedIndex++;
        [self insertSubview:[loadedCards objectAtIndex:(MAX_BUFFER_SIZE-1)] belowSubview:[loadedCards objectAtIndex:(MAX_BUFFER_SIZE-2)]];
    }
}

- (void)swipeToRight {
    DraggableView *dragView = [loadedCards firstObject];
    dragView.overlayView.mode = overlayViewModeRight;
    [UIView animateWithDuration:0.2 animations:^{
        dragView.overlayView.alpha = 1;
    }];
    
    [dragView rightClickAction];
}

- (void)swipeToLeft {
    DraggableView *dragView = [loadedCards firstObject];
    dragView.overlayView.mode = overlayViewModeLeft;
    [UIView animateWithDuration:0.2 animations:^{
        dragView.overlayView.alpha = 1;
    }];
    
    [dragView leftClickAction];
}



@end

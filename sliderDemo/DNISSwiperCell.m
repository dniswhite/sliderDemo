//
//  DNISSwiperCell.m
//
//  Created by Dennis White on 1/4/14.
//  Copyright (c) 2014 dniswhite. All rights reserved.
//

#import "DNISSwiperCell.h"

static CGFloat const sliderAnimationDuration = 0.25;

@interface DNISSwiperCell()

@property UIPanGestureRecognizer *swipingGesture;

@end

@implementation DNISSwiperCell

-(void)initSwiperCell
{
    [self setSwipingGesture:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(gestureSwipeLeft:)]];
    
    CGRect parentFrame = [self frame];
    
    [[self swipingGesture] setMaximumNumberOfTouches:1];
    [[self swipingGesture] setMinimumNumberOfTouches:1];
    [[self swipingGesture] setDelegate: self];
    
    [self setSwiperContentView: [[UIView alloc] initWithFrame: parentFrame]];
    [[self swiperContentView] setBackgroundColor:[UIColor whiteColor]];
    [[self swiperContentView] addGestureRecognizer:[self swipingGesture]];
    
    [self setSwiperButtonView: [[UIView alloc] initWithFrame: parentFrame]];
    
    [self addSubview: [self swiperButtonView]];
    [self addSubview: [self swiperContentView]];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self initSwiperCell];
    }
    
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];

    if (self) {
        [self initSwiperCell];
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

#pragma swiping gesture implementation for delegate

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if ([UIPanGestureRecognizer class] == [gestureRecognizer class]) {
        UIPanGestureRecognizer *instance = (UIPanGestureRecognizer *) gestureRecognizer;
        CGPoint point = [instance velocityInView:self.swiperContentView];
        if (fabsf(point.x) > fabsf(point.y)) {
            return YES;
        }
    }
    return NO;
}

#pragma implementation for gesture action

-(void)gestureSwipeLeft:(UIPanGestureRecognizer *)sender
{
    CGPoint translatedPoint = [(UIPanGestureRecognizer *)sender translationInView:self.swiperContentView];
    
    if ([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
        firstX = [[sender view] center].x;

        if ([[self delegate] respondsToSelector:@selector(swiperCellSwipeHasStarted:)]) {
            [[self delegate] swiperCellSwipeHasStarted:self];
        }
    }
    
    if (firstX+translatedPoint.x > self.frame.size.width/2){
        translatedPoint = CGPointMake(self.frame.size.width/2, [[sender view] center].y);
    } else if (firstX+translatedPoint.x <self.frame.size.width/2 - [self swipperButtonViewWidth]) {
        translatedPoint = CGPointMake(self.frame.size.width/2 - [self swipperButtonViewWidth], [[sender view] center].y);
    } else {
        translatedPoint = CGPointMake(firstX+translatedPoint.x, [[sender view] center].y);
    }
 
    [[sender view] setCenter:translatedPoint];
 
    if ([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded || [(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateCancelled) {
        if ([[self delegate] respondsToSelector:@selector(swiperCellSwipeHasStopped:)]) {
            [[self delegate] swiperCellSwipeHasStopped:self];
        }
        
        CGFloat velocityX = [(UIPanGestureRecognizer*)sender velocityInView:self.swiperContentView].x;
        CGFloat destinationX = translatedPoint.x + velocityX;
        
        if (destinationX < ([self center].x - [self swipperButtonViewWidth])) {
            destinationX = [self center].x - [self swipperButtonViewWidth];
            if ([[self delegate] respondsToSelector:@selector(swiperCellIsOpen:)]) {
                [[self delegate] swiperCellIsOpen:self];
            }
        } else {
            destinationX = [self center].x;
            if ([[self delegate] respondsToSelector:@selector(swiperCellIsClosed:)]) {
                [[self delegate] swiperCellIsClosed:self];
            }
        }
        
        [UIView animateWithDuration:sliderAnimationDuration animations:^{
            [[self swiperContentView] setCenter:CGPointMake(destinationX, [[self swiperContentView] center].y) ];
        }];
    }
}

@end

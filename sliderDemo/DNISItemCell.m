//
//  DNISItemCell.m
//  sliderDemo
//
//  Created by Dennis White on 1/27/14.
//  Copyright (c) 2014 dniswhite. All rights reserved.
//

#import "DNISItemCell.h"

@implementation DNISItemCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if(self){
        CGRect frame = [[self swiperButtonView] bounds];
        [self setMoreInfoButton:[[UIButton alloc] initWithFrame:CGRectMake(frame.size.width-(80*2), 0, 80, 45)]];
        [[self moreInfoButton] setTitle:@"More" forState:UIControlStateNormal];
        [[self moreInfoButton] setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [[self moreInfoButton] setBackgroundColor:[UIColor grayColor]];
        
        [self setDeleteButton:[[UIButton alloc] initWithFrame:CGRectMake(frame.size.width-(80*1), 0, 80, 45)]];
        [[self deleteButton] setTitle:@"Delete" forState:UIControlStateNormal];
        [[self deleteButton] setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [[self deleteButton] setBackgroundColor:[UIColor redColor]];
        
        [[self swiperButtonView] addSubview:[self moreInfoButton]];
        [[self swiperButtonView] addSubview:[self deleteButton]];
        
        [self setTitleLabel:[[UILabel alloc] initWithFrame:CGRectMake(15, 3, 300, 22)]];
        [[self titleLabel] setFont:[UIFont systemFontOfSize:18]];
        [[self titleLabel] setNumberOfLines:1];
        [[self titleLabel] setBaselineAdjustment:UIBaselineAdjustmentNone];
        [[self titleLabel] setAdjustsFontSizeToFitWidth:YES];
        [[self titleLabel] setMinimumScaleFactor:10.0f/12.0f];
        [[self titleLabel] setClipsToBounds:YES];
        [[self titleLabel] setBackgroundColor:[UIColor clearColor]];
        [[self titleLabel] setTextColor:[UIColor blackColor]];
        [[self titleLabel] setTextAlignment:NSTextAlignmentLeft];
        
        [self setDetailLabel:[[UILabel alloc] initWithFrame:CGRectMake(15, 25, 300, 15)]];
        
        [[self detailLabel] setFont:[UIFont systemFontOfSize:12]];
        [[self detailLabel] setNumberOfLines: 1];
        [[self detailLabel] setBaselineAdjustment:UIBaselineAdjustmentNone];
        [[self detailLabel] setAdjustsFontSizeToFitWidth:YES];
        [[self detailLabel] setMinimumScaleFactor: 10.0f/12.0f];
        [[self detailLabel] setClipsToBounds: YES];
        [[self detailLabel] setBackgroundColor:[UIColor clearColor]];
        [[self detailLabel] setTextColor:[UIColor blackColor]];
        [[self detailLabel] setTextAlignment:NSTextAlignmentLeft];
        
        [[self swiperContentView] addSubview:[self titleLabel]];
        [[self swiperContentView] addSubview:[self detailLabel]];
        
        [self setSwipperButtonViewWidth:160];
    }
    
    return self;
}

-(void)initWithItem:(DNISItem *)item
{
    [[self titleLabel] setText:[item itemName]];
    [[self detailLabel] setText:@"This is where the subtitle text will go and hopefully it stretches out long enough."];
    
    // change the boundary information in case the device orientation has changed
    CGRect bounds = [self bounds];
    
    [[self swiperButtonView] setFrame:bounds];
    [[self swiperContentView] setFrame:bounds];
    
    [[self moreInfoButton] setFrame:CGRectMake(bounds.size.width-(80*2), 0, 80, bounds.size.height)];
    [[self deleteButton] setFrame:CGRectMake(bounds.size.width-(80*1), 0, 80, bounds.size.height)];
}

@end

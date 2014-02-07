//
//  DNISItem.m
//  sliderDemo
//
//  Created by Dennis White on 1/27/14.
//  Copyright (c) 2014 dniswhite. All rights reserved.
//

#import "DNISItem.h"

@implementation DNISItem

-(id)init
{
    self = [super init];
    
    if(self) {
        [self setCreationDate:[NSDate date]];
        [self setDeleted:NO];
        [self setSliderOpen:NO];
    }
    
    return self;
}

@end

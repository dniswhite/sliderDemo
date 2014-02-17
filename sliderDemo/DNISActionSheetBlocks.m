//
//  DNISActionSheetBlocks.m
//  sliderDemo
//
//  Created by Dennis White on 2/16/14.
//  Copyright (c) 2014 dniswhite. All rights reserved.
//

#import "DNISActionSheetBlocks.h"

@interface DNISActionSheetBlocks () <UIActionSheetDelegate>

@end

@implementation DNISActionSheetBlocks

-(id) initWithTitle: (NSString *) title
{
    self = [self initWithTitle:title delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil, nil];
    
    return self;
}

-(id) initWithButtons: (NSString *) cancelButtonTitle destructiveButtonTitle:(NSString *) destructiveButtonTitle otherButtonTitles:(NSString *) otherButtonTitles, ...
{
    self = [self initWithTitle:nil];
    
    if (self) {
        if (nil != otherButtonTitles) {
            [self addButtonWithTitle:otherButtonTitles];
            
            va_list arguments;
            id eachObject;
            
            va_start(arguments, otherButtonTitles);
            while ((eachObject = va_arg(arguments, id)))
            {
                [self addButtonWithTitle:eachObject];
            }
            va_end(arguments);
        }
        
        if (nil != cancelButtonTitle) {
            NSInteger index = [self addButtonWithTitle:cancelButtonTitle];
            [self setCancelButtonIndex:index];
        }
        
        if (nil != destructiveButtonTitle) {
            NSInteger index = [self addButtonWithTitle:destructiveButtonTitle];
            [self setDestructiveButtonIndex:index];
        }
    }
    
    return self;
}

-(id) initWithTitleAndButtons:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    self = [self initWithTitle:title];
    
    if (self) {
        if (nil != otherButtonTitles) {
            [self addButtonWithTitle:otherButtonTitles];

            va_list arguments;
            id eachObject;

            va_start(arguments, otherButtonTitles);
            while ((eachObject = va_arg(arguments, id)))
            {
                [self addButtonWithTitle:eachObject];
            }
            va_end(arguments);
        }
        
        if (nil != cancelButtonTitle) {
            NSInteger index = [self addButtonWithTitle:cancelButtonTitle];
            [self setCancelButtonIndex:index];
        }
        
        if (nil != destructiveButtonTitle) {
            NSInteger index = [self addButtonWithTitle:destructiveButtonTitle];
            [self setDestructiveButtonIndex:index];
        }
    }
    
    return self;
}

#pragma responding to actions
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"blockClickedButton was called");
    if([self blockClickedButton] != nil) {
        [self blockClickedButton](actionSheet, buttonIndex);
    }
}

#pragma customizing behavior
-(void) willPresentActionSheet:(UIActionSheet *)actionSheet
{
    NSLog(@"blockWillPresentActionSheet was called");
    if ([self blockWillPresentActionSheet] != nil) {
        [self blockWillPresentActionSheet](actionSheet);
    }
}

-(void) didPresentActionSheet:(UIActionSheet *)actionSheet
{
    NSLog(@"blockDidPresentActionSheet was called");
    if ([self blockDidPresentActionSheet] != nil) {
        [self blockDidPresentActionSheet](actionSheet);
    }
}

-(void) actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSLog(@"blockWillDismissWithButton was called");
    if ([self blockWillDismissWithButton] != nil) {
        [self blockWillDismissWithButton](actionSheet, buttonIndex);
    }
}

-(void) actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSLog(@"blockDidDismissWithButton was called");
    if ([self blockDidDismissWithButton] != nil) {
        [self blockDidDismissWithButton](actionSheet, buttonIndex);
    }
}

#pragma cancelling
-(void) actionSheetCancel:(UIActionSheet *)actionSheet
{
    NSLog(@"blockActionSheetCancel was called");
    if ([self blockActionSheetCancel] != nil) {
        [self blockActionSheetCancel](actionSheet);
    }
}

@end

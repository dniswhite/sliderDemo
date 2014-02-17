//
//  DNISActionSheetBlocks.h
//  sliderDemo
//
//  Created by Dennis White on 2/16/14.
//  Copyright (c) 2014 dniswhite. All rights reserved.
//

#import <UIKit/UIKit.h>

// typedefs for the blocks that will represent UIActionSheetDelegate
typedef void(^DNISActionSheetButtonIndex)(UIActionSheet * actionSheet, NSInteger buttonIndex);
typedef void(^DNISActionSheet)(UIActionSheet * actionSheet);

@interface DNISActionSheetBlocks : UIActionSheet

-(id) initWithTitleAndButtons:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...;

-(id) initWithTitle: (NSString *) title;
-(id) initWithButtons: (NSString *) cancelButtonTitle destructiveButtonTitle:(NSString *) destructiveButtonTitle otherButtonTitles:(NSString *) otherButtonTitles, ...;

@property (strong) DNISActionSheetButtonIndex blockClickedButton;
@property (strong) DNISActionSheet blockWillPresentActionSheet;
@property (strong) DNISActionSheet blockDidPresentActionSheet;
@property (strong) DNISActionSheetButtonIndex blockDidDismissWithButton;
@property (strong) DNISActionSheetButtonIndex blockWillDismissWithButton;
@property (strong) DNISActionSheet blockActionSheetCancel;

@end

//
//  XYZSwiperCell.h
//  ToDoList
//
//  Created by Dennis White on 1/4/14.
//  Copyright (c) 2014 dniswhite. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DNISSwiperCell : UITableViewCell {
    int firstX;
}

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIView *buttonView;

@property BOOL cellClosed;
@property int buttonCellWidth;

@end

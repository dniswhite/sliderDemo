//
//  DNISSwiperCell.h
//
//  Created by Dennis White on 1/4/14.
//  Copyright (c) 2014 dniswhite. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DNISSwiperCell;

@protocol DNISSwiperDelegate <NSObject>

@optional
-(void) swiperCellSwipeHasStarted: (DNISSwiperCell *) sender;
-(void) swiperCellSwipeHasStopped: (DNISSwiperCell *) sender;
-(void) swiperCellIsOpen: (DNISSwiperCell *) sender;
-(void) swiperCellIsClosed:(DNISSwiperCell *) sender;

@end

@interface DNISSwiperCell : UITableViewCell {
    int firstX;
}

@property (nonatomic, strong) UIView * swiperButtonView;
@property (nonatomic, strong) UIView * swiperContentView;

@property (nonatomic, assign) id delegate;

@property int swipperButtonViewWidth;

@end

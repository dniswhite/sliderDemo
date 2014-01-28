//
//  DNISItemCell.h
//  sliderDemo
//
//  Created by Dennis White on 1/27/14.
//  Copyright (c) 2014 dniswhite. All rights reserved.
//

#import "DNISSwiperCell.h"
#import "DNISItem.h"

@interface DNISItemCell : DNISSwiperCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;

@property (nonatomic, strong) UIButton *moreInfoButton;
@property (nonatomic, strong) UIButton *deleteButton;

-(void) initWithItem:(DNISItem *) item;

@end

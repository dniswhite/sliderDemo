//
//  DNISItem.h
//  sliderDemo
//
//  Created by Dennis White on 1/27/14.
//  Copyright (c) 2014 dniswhite. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DNISItem : NSObject

@property NSString * itemName;
@property NSDate * creationDate;

@property (getter = isDeleted) BOOL deleted;

@end

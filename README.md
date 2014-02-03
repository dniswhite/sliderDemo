sliderDemo
==========
<p align="center"><img src="https://raw.github.com//dniswhite/sliderDemo/master/demo/sliderDemo.gif"></p>

Was curious about making a sliding cell and came across [SWTableViewCell](https://github.com/CEWendel/SWTableViewCell) and was curious if I could simplify. This is by no means an improvement on it but rather a test to see if I could do something simpler. 

##Usage

###Example
Review through the sample application for an example of how to use everything.

###Cell Swiping
The buttons or whatever you place in the 'swiperButtonView' get displayed when the user swipes to the left on any given cell.

###Notifcation
There are delegates in place to keep you notified when the user starts to swipe and when they have finished as well as for when the cell has opened and closed.

'''objc
@interface DNISItemsViewController () <UIActionSheetDelegate, DNISSwiperDelegate>
'''

'''objc
-(void) swiperCellSwipeHasStarted: (DNISSwiperCell *) sender
{
    NSLog(@"swipe has started");
}

-(void) swiperCellSwipeHasStopped: (DNISSwiperCell *) sender;
{
    NSLog(@"swipe has stopped");
}

-(void) swiperCellIsClosed:(DNISSwiperCell *)sender
{
    NSLog(@"cell is closed");
}

-(void) swiperCellIsOpen:(DNISSwiperCell *)sender
{
    NSLog(@"cell is open");
}
'''

###Inheritance
By itself 'DNISSwiperCell' does nothing for you. It is expected that you (developer) will extend it to fit your needs. What is given to you is a content view 'swiperContentView' where you place the information that is normally displayed and then 'swiperButtonView' which is where you place the content to be displayed when the user swipes left. 

####.h 
'''objc
#import "DNISSwiperCell.h"
#import "DNISItem.h"

@interface DNISItemCell : DNISSwiperCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;

@property (nonatomic, strong) UIButton *moreInfoButton;
@property (nonatomic, strong) UIButton *deleteButton;

-(void) initWithItem:(DNISItem *) item;

@end
'''

####.m 
'''objc
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

@end
'''
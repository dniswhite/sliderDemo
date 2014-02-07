//
//  DNISItemsViewController.m
//  sliderDemo
//
//  Created by Dennis White on 1/27/14.
//  Copyright (c) 2014 dniswhite. All rights reserved.
//

#import "DNISItemsViewController.h"
#import "DNISItem.h"
#import "DNISItemCell.h"
#import <UIKit/UIActionSheet.h>

@interface DNISItemsViewController () <UIActionSheetDelegate, DNISSwiperDelegate>

@property NSMutableArray * listItems;

@end

@implementation DNISItemsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) createListItems
{
    // just create some random data to fill up the table
    for (int count = 0; count < 30; count++) {
        DNISItem *item = [[DNISItem alloc] init];
        [item setItemName: [[NSString alloc] initWithFormat:@"List Item %d", count]];
        
        [[self listItems] addObject:item];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setListItems:[[NSMutableArray alloc] init]];
    [self createListItems];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *items = [[NSArray alloc] init];
    items = [[self listItems] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"isDeleted == %d", NO]];
    
    return [items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    DNISItemCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSArray *items = [[NSArray alloc] init];
    items = [[self listItems] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"isDeleted == %d", NO]];
    
    // Configure the cell...
    [cell setDelegate:self];

    [cell initWithItem:[items objectAtIndex:[indexPath row]]];
    
    [[cell moreInfoButton] removeTarget:self action:@selector(moreInfoButton:) forControlEvents:UIControlEventTouchUpInside];
    [[cell moreInfoButton] addTarget:self action:@selector(moreInfoButton:) forControlEvents:UIControlEventTouchUpInside];
    [[cell moreInfoButton] setTag:[indexPath row]];
    
    [[cell deleteButton] removeTarget:self action:@selector(deleteButton:) forControlEvents:UIControlEventTouchUpInside];
    [[cell deleteButton] addTarget:self action:@selector(deleteButton:) forControlEvents:UIControlEventTouchUpInside];
    [[cell deleteButton] setTag:[indexPath row]];
    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[self tableView] deselectRowAtIndexPath:indexPath animated:YES];

    DNISItem * item = [[self listItems] objectAtIndex:indexPath.row];
    
    (YES == item.isSliderOpen) ? NSLog(@"YES") : NSLog(@"NO");
    
    if (YES == item.isSliderOpen) {
        [[self tableView] setScrollEnabled:YES];
        [[self tableView] reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
        
        [item setSliderOpen:NO];
    }
}

-(void) moreInfoButton:(UIButton *) sender
{
    NSLog(@"more button clicked for row %d", sender.tag);

    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"#1 Action Button", @"#2 Action Button", nil];
    
    [actionSheet setTag:[sender tag]];
    [actionSheet setActionSheetStyle:UIActionSheetStyleDefault];
    [actionSheet showInView: [self view]];
}

-(void) deleteButton: (UIButton *) sender
{
    NSLog(@"delete button clicked for row %d", sender.tag);
    
    DNISItem * item = [[self listItems] objectAtIndex:[sender tag]];
    [item setDeleted:YES];
    [item setSliderOpen:NO];
    
    [[self tableView] setScrollEnabled:YES];
    [[self tableView] reloadData];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"button index %d was clicked for row %d", buttonIndex, [actionSheet tag]);

    NSArray *items = [[NSArray alloc] init];
    items = [[self listItems] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"isSliderOpen == %d", YES]];
    
    if (0 < [items count]) {
        [[self tableView] setScrollEnabled:YES];
        
        for (DNISItem * item in items) {
            [item setSliderOpen:NO];
        }
    }
    
    [[self tableView] reloadData];
}

-(void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    NSLog(@"rotating device and resetting rows");

    NSArray *items = [[NSArray alloc] init];
    items = [[self listItems] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"isSliderOpen == %d", YES]];
    
    if (0 < [items count]) {
        [[self tableView] setScrollEnabled:YES];

        for (DNISItem * item in items) {
            [item setSliderOpen:NO];
        }
    }

    [[self tableView] reloadData];
}

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

    NSIndexPath * indexPath = [[self tableView] indexPathForCell:sender];
    DNISItem * item = [[self listItems] objectAtIndex:indexPath.row];
    
    [item setSliderOpen:NO];
    [[self tableView] setScrollEnabled:YES];
}

-(void) swiperCellIsOpen:(DNISSwiperCell *)sender
{
    NSLog(@"cell is open");

    NSIndexPath * indexPath = [[self tableView] indexPathForCell:sender];
    DNISItem * item = [[self listItems] objectAtIndex:indexPath.row];
    
    NSLog(@"%@", item.itemName);
    
    if ([item itemName] == nil) {
        NSLog(@"empty");
    }
    
    [item setSliderOpen:YES];
    [[self tableView] setScrollEnabled:NO];
}

-(BOOL) swiperRecognizeGesture:(DNISSwiperCell *)sender
{
    NSArray *items = [[NSArray alloc] init];
    items = [[self listItems] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"isSliderOpen == %d", YES]];
    NSIndexPath * indexPath = [[self tableView] indexPathForCell:sender];
    
    DNISItem * item = [[self listItems] objectAtIndex:indexPath.row];
    if ([item isSliderOpen] == YES) {
        return YES;
    }
    
    if ([items count] >= 1) {
        return NO;
    }
    
    return YES;
}

@end

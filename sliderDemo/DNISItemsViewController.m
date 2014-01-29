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

@interface DNISItemsViewController () <UIActionSheetDelegate>

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
    DNISItem *item = [[DNISItem alloc] init];
    [item setItemName:@"List Item One"];
    
    [[self listItems] addObject:item];
    
    DNISItem *item1 = [[DNISItem alloc] init];
    [item1 setItemName:@"List Item Two"];
    
    [[self listItems] addObject:item1];
    
    DNISItem *item2 = [[DNISItem alloc] init];
    [item2 setItemName:@"List Item Three"];
    
    [[self listItems] addObject:item2];
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
    
    [cell initWithItem:[items objectAtIndex:[indexPath row]]];
     
    [[cell textLabel] setText:[[items objectAtIndex:[indexPath row]] itemName]];
    
    // Configure the cell...
    [[cell moreInfoButton] addTarget:self action:@selector(moreInfoButton:) forControlEvents:UIControlEventTouchUpInside];
    [[cell moreInfoButton] setTag:[indexPath row]];
    
    [[cell deleteButton] addTarget:self action:@selector(deleteButton:) forControlEvents:UIControlEventTouchUpInside];
    [[cell deleteButton] setTag:[indexPath row]];
    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[self tableView] deselectRowAtIndexPath:indexPath animated:YES];
    [[self tableView] reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
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
    
    [[self tableView] reloadData];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"button index %d was clicked for row %d", buttonIndex, [actionSheet tag]);
    [[self tableView] reloadData];
}

-(void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    // for now when the devices changes orientation reload the data
    [[self tableView] reloadData];
}
@end

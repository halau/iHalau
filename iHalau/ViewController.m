//
//  ViewController.m
//  iHalau
//
//  Created by mzp on 2012/08/04.
//  Copyright (c) 2012年 mzp. All rights reserved.
//

#import "ViewController.h"
#import "ItemDetailViewController.h"
#import "Halau.h"
#import "Item.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)refreshData
{
    // If section's number are changed, deleteRowsAtIndexPaths raises error.
    // So, DONT upadte dateSection
    [halau refresh];
    [data removeAllObjects];

    NSCalendar* gregorian = [NSCalendar currentCalendar];
    NSArray* items = [halau items];

    for (Item* item in items) {
        NSDateComponents *current = [gregorian components: NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit
                                                 fromDate: item.createdAt];
        NSMutableArray* xs = [data objectForKey:current];
        if( xs == nil) {
            xs = [[NSMutableArray alloc] init];
        }
        [xs addObject:item];
        [data setObject:xs forKey:current];
        if( ![dateSection containsObject:current]) {
            [dateSection addObject: current];
        }
    }
}

- (void)refresh
{
    [dateSection removeAllObjects];
    [self refreshData];
    [itemsTableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    data = [[NSMutableDictionary alloc] init];
    dateSection = [[NSMutableArray alloc] init];
    halau = [[Halau alloc] initWithUrl:@"http://127.0.0.1:4567"];
    [self refresh];
}

- (void)viewDidUnload
{
    itemsTableView = nil;
    editButton = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)edit:(id)sender {

    if( [itemsTableView isEditing]) {
        [editButton setTitle: @"Edit"];
        [itemsTableView setEditing:NO animated:YES];
        [self refresh];
    } else {
        [editButton setTitle: @"Done"];
        [itemsTableView setEditing:YES animated:YES];
    }
}

- (IBAction)add:(id)sender {
    ItemDetailViewController* detailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ItemDetailViewController"];
    detailViewController.onDone = ^(Item* item){
        [halau addItem:item];
        [self refresh];
    };
    [self presentModalViewController:detailViewController animated:YES];
}

- (IBAction)refresh:(id)sender {
    [self refresh];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [dateSection count];
}

- (NSArray*) itemsForSection:(NSInteger)section{
    NSDateComponents* comp = (NSDateComponents*)[dateSection objectAtIndex:section];
    return [data objectForKey:comp];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSArray* xs = [self itemsForSection:section];
    NSDate* date = ((Item*)[xs objectAtIndex:0]).createdAt;
    NSString* title = [NSDateFormatter localizedStringFromDate:date
                                          dateStyle:NSDateFormatterMediumStyle
                                          timeStyle:NSDateFormatterNoStyle];
    return title;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray* xs = [self itemsForSection:section];
    return [xs count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ItemCell"];
    UIImageView* icon = (UIImageView*)[cell viewWithTag:1];
    UILabel* itemName = (UILabel*)[cell viewWithTag:2];
    UILabel* location = (UILabel*)[cell viewWithTag:3];
    UILabel* price = (UILabel*)[cell viewWithTag:4];

    NSArray* xs = [self itemsForSection:indexPath.section];
    Item*  item = [xs objectAtIndex: indexPath.row];

    NSNumberFormatter* formatter = [[NSNumberFormatter alloc] init];
    formatter.positiveFormat = @"#,##0";
    icon.image = [UIImage imageNamed:@"hoby.png"];
    itemName.text = item.name;
    location.text = [NSString stringWithFormat:@"@%@", item.location];
    price.text = [NSString stringWithFormat:@"%@円", [formatter stringFromNumber: [NSNumber numberWithInteger:item.price]]];

    return cell;
}

- (void)tableView:(UITableView*)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( editingStyle == UITableViewCellEditingStyleDelete ) {
        Item* item = [[halau items] objectAtIndex: indexPath.row];
        [halau removeItem:item];
        [self refreshData];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject: indexPath] withRowAnimation:YES];
    }
}


@end

//
//  ItemDetailViewController.m
//  iHalau
//
//  Created by mzp on 2012/08/05.
//  Copyright (c) 2012年 mzp. All rights reserved.
//

#import "ItemDetailViewController.h"
#import "Item.h"

@interface ItemDetailViewController ()

@end

@implementation ItemDetailViewController
@synthesize onDone;

- (IBAction)cancel:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)done:(id)sender {
    Item* aItem = [[Item alloc] initWith: -1
                                   name: name.text
                               category: @"hoby"
                               location: location.text
                                  price: [price.text intValue]
                              createdAt: [NSDate date]];
    if(self.onDone != nil) {
        self.onDone(aItem);
    }
    [self dismissModalViewControllerAnimated:YES];
}

- (void)viewDidUnload {
    name = nil;
    location = nil;
    price = nil;
    [super viewDidUnload];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self update];
}

- (void)setItem:(Item *)aItem
{
    item = aItem;
    [self update];
}

- (void)update {
    name.text = item.name;
    location.text = item.location;
    price.text = [NSString stringWithFormat:@"%d", item.price,nil];
}
@end

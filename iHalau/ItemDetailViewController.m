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
    Item* item = [[Item alloc] initWith: name.text
                               category: @"hoby"
                               location: location.text
                                  price: [price.text intValue]
                              createdAt: [NSDate date]];
    if(self.onDone != nil) {
        self.onDone(item);
    }
    [self dismissModalViewControllerAnimated:YES];
}

- (void)viewDidUnload {
    name = nil;
    location = nil;
    price = nil;
    [super viewDidUnload];
}
@end

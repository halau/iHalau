//
//  ItemDetailViewController.h
//  iHalau
//
//  Created by mzp on 2012/08/05.
//  Copyright (c) 2012年 mzp. All rights reserved.
//
#import <UIKit/UIKit.h>
@class Item;

typedef void (^ItemListener)(Item*);

@interface ItemDetailViewController : UIViewController
{
    __weak IBOutlet UITextField *name;
    __weak IBOutlet UITextField *location;
    __weak IBOutlet UITextField *price;
}

@property(nonatomic, copy) void (^onDone)(Item*);

- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

@end

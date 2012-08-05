//
//  ViewController.h
//  iHalau
//
//  Created by mzp on 2012/08/04.
//  Copyright (c) 2012年 mzp. All rights reserved.
//
#import <UIKit/UIKit.h>


@class Halau;
@interface ViewController : UIViewController<UITableViewDataSource> {
    __weak IBOutlet UITableView *itemsTableView;
    Halau* halau;
    NSMutableArray* dateSection;
    NSMutableDictionary* data;
}
- (IBAction)edit:(id)sender;
- (IBAction)add:(id)sender;
- (IBAction)refresh:(id)sender;

@end

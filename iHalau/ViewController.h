//
//  ViewController.h
//  iHalau
//
//  Created by mzp on 2012/08/04.
//  Copyright (c) 2012年 mzp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource> {
    __weak IBOutlet UITableView *itemsTableView;
/*    NSArray* data;
    NSMutableArray* dateSection;
    NSCalendar* gregorian;*/
    NSMutableArray* dateSection;
    NSMutableDictionary* data;
}
- (IBAction)edit:(id)sender;
- (IBAction)add:(id)sender;
- (IBAction)refresh:(id)sender;

@end

//
//  Halau.h
//  iHalau
//
//  Created by mzp on 2012/08/05.
//  Copyright (c) 2012年 mzp. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Item;
@interface Halau : NSObject {
    NSString* url;
    NSArray*  items;
}

@property (nonatomic, retain, readonly) NSArray* items;

- (id)initWithUrl:(NSString*)aUrl;
- (void)refresh;	
- (void)addItem:(Item*)item;
- (void)removeItem:(Item*)item;
- (void)updateItem:(Item*)item;
@end

//
//  Item.m
//  iHalau
//
//  Created by mzp on 2012/08/04.
//  Copyright (c) 2012年 mzp. All rights reserved.
//

#import "Item.h"

@implementation Item
@synthesize categroy, name, location, price, createdAt;

- (id)initWith:(NSString*)aName
      category:(NSString*)aCategory
      location:(NSString*)aLocation
         price:(NSInteger)aPrice
     createdAt:(NSDate*)aCreatedAt
{
    if( self = [super init] ) {
        self.name = aName;
        self.categroy = aCategory;
        self.location = aLocation;
        self.price = aPrice;
        self.createdAt = aCreatedAt;
    }
    return self;
}
@end

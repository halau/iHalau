//
//  Item.h
//  iHalau
//
//  Created by mzp on 2012/08/04.
//  Copyright (c) 2012年 mzp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item : NSObject

@property (nonatomic, retain) NSString* categroy;
@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* location;
@property (nonatomic) NSInteger price;
@property (nonatomic, retain) NSDate* createdAt;

- (id)initWith:(NSString*)name
      category:(NSString*)category
      location:(NSString*)location
         price:(NSInteger)price
     createdAt:(NSDate*)aDate;
@end

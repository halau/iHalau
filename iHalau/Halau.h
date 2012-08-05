//
//  Halau.h
//  iHalau
//
//  Created by mzp on 2012/08/05.
//  Copyright (c) 2012年 mzp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Halau : NSObject {
    NSString* url;
    NSArray*  items;
}

@property (nonatomic, retain, readonly) NSArray* items;

- (id)initWithUrl:(NSString*)aUrl;
- (void)refresh;	

@end

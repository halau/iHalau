//
//  Halau.m
//  iHalau
//
//  Created by mzp on 2012/08/05.
//  Copyright (c) 2012年 mzp. All rights reserved.
//

#import "Halau.h"
#import "SBJson.h"
#import "Item.h"

@implementation Halau
@synthesize items;
- (id)initWithUrl:(NSString*)aUrl
{
    if( self = [super init]) {
        url = aUrl;
        items = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSURL*)api:(NSString*)path {
    return [NSURL URLWithString:[NSString stringWithFormat: @"%@/%@", url, path]];
}

- (NSDate *)parse:(NSString *)rfc3339DateTimeString {
    /*
     Returns a user-visible date time string that corresponds to the specified
     RFC 3339 date time string. Note that this does not handle all possible
     RFC 3339 date time strings, just one of the most common styles.
     */
    
    NSDateFormatter *rfc3339DateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *enUSPOSIXLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    
    [rfc3339DateFormatter setLocale:enUSPOSIXLocale];
    [rfc3339DateFormatter setDateFormat:@"yyyy'-'MM'-'dd' 'HH':'mm':'ss  '0000'"];
    [rfc3339DateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    // Convert the RFC 3339 date time string to an NSDate.
    NSDate *date = [rfc3339DateFormatter dateFromString:rfc3339DateTimeString];
    return date;
}
    
- (void)refresh {
    [(NSMutableArray*)items removeAllObjects];
    NSURLRequest *request = [NSURLRequest requestWithURL:[self api:@"items.json"]];
    NSData *jsonData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSArray *json = [parser objectWithData: jsonData];

    for(NSDictionary* dict in json) {
        NSString* s = [dict objectForKey: @"createdAt"];
        NSDate* date = [self parse: s];
        Item* item = [[Item alloc] initWith: [(NSNumber*)[dict objectForKey: @"id"]  intValue]
                                       name: (NSString*)[dict objectForKey: @"name"]
                                   category: (NSString*)[dict objectForKey: @"category"]
                                   location: (NSString*)[dict objectForKey: @"location"]
                                      price: [(NSNumber*)[dict objectForKey: @"price"]  intValue]
                                  createdAt: date];
        [(NSMutableArray*)items addObject: item];
    }
}

- (void)addItem:(Item*)item
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[self api:@"addItem"]];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    request.HTTPMethod = @"POST";
    request.HTTPBody   = [[NSString stringWithFormat:@"name=%@&location=%@&price=%d&category=%@&createdAt=%@",
                           item.name, item.location, item.price, item.categroy, item.createdAt, nil]
                          dataUsingEncoding:NSUTF8StringEncoding];
    NSData* retval = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSLog(@"%@", retval);
}

@end

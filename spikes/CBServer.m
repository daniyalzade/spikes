//
//  CBServer.m
//  spikes
//
//  Created by eytan on 9/13/12.
//  Copyright (c) 2012 chartbeat. All rights reserved.
//

#import "CBServer.h"
#import "ApikeyDB.h"

static CBServer* instance;

@interface CBServer()

@property NSMutableArray* domains;

@end

@implementation CBServer

@synthesize domains = _domains;
- (id)init
{
    self = [super init];
    [self updateDomains];
    return self;
}

- (NSArray*) updateDomains {
    NSString* apikey = [ApikeyDB getApikey];
    NSDictionary *params = @{ @"apikey": apikey};
    NSString *paramsStr = [self encodeParameters:params];
    NSURL *url = [NSURL URLWithString:[SERVER_ADDR stringByAppendingFormat: @"dashapi/domains%@", paramsStr]];
//    NSLog(@"url %@", url);
    NSDictionary *response = [self sendRequestToURL:url];
//    NSLog(@"response: %@", response);
    self.domains = [response objectForKey:@"domains"];
    return self.domains;
}


- (NSString *) encodeParameters: (NSDictionary *) parameters
{
    NSString *requestString = @"";
    for (NSString *key in [parameters allKeys]) {
        requestString = [requestString stringByAppendingFormat:@"%@%@=%@", (requestString.length > 0) ? @"&" : @"?", key, [parameters objectForKey:key]];
    }
    return requestString;
}

- (NSArray*) getDomains {
    return self.domains;
}

- (NSArray*) getSpikes: (NSString *) domain {
    NSString* apikey = [ApikeyDB getApikey];
    NSDictionary *params = @{ @"apikey": apikey, @"limit": @10, @"host": domain};
    NSString *paramsStr = [self encodeParameters:params];
    NSURL *url = [NSURL URLWithString:[SERVER_ADDR stringByAppendingFormat: @"historical/spikes/%@", paramsStr]];
    NSLog(@"url %@", url);
    NSDictionary *response = [self sendRequestToURL:url];
    NSLog(@"response: %@", response);
    return [[response objectForKey:@"data"] objectForKey:@"spikes"];
}

+ (CBServer*) getInstance {
    if (!instance) {
        instance = [[CBServer alloc] init];
    }
    return instance;
}

- (NSDictionary *)sendRequestToURL: (NSURL *) url
{
    // form request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod: @"GET" ];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    
    NSHTTPURLResponse *response = nil;
    NSError *error = nil;
    
    // send request
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    // Check if an error occurred
    if (error) {
        [NSException raise:@"Unable to connect to the server" format:@""];
    }
    // Convert the response data to a NSDictionary / NSString
    id responseJSON = [NSJSONSerialization JSONObjectWithData: responseData options: NSJSONReadingMutableContainers error: &error];
    
    return responseJSON;
}

@end

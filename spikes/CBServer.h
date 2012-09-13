//
//  CBServer.h
//  spikes
//
//  Created by eytan on 9/13/12.
//  Copyright (c) 2012 chartbeat. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SERVER_ADDR @"http://chartbeat.com/"

@interface CBServer : NSObject

+ (CBServer*) getInstance;
- (NSArray*) updateDomains;
- (NSArray*) getDomains;
- (NSArray*) getSpikes: (NSString *)domain;

@end

//
//  ApikeyDB.h
//  spikes
//
//  Created by eytan on 9/11/12.
//  Copyright (c) 2012 chartbeat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApikeyDB : NSObject

+ (NSString*) getApikey;
+ (void) setApikey: (NSString*) apikey;

@end

//
//  ApikeyDB.m
//  spikes
//
//  Created by eytan on 9/11/12.
//  Copyright (c) 2012 chartbeat. All rights reserved.
//

#import "ApikeyDB.h"

@implementation ApikeyDB

+ (NSString* ) getApikey {
    NSString *apikey = [NSString stringWithContentsOfFile: [ApikeyDB getFilename]];
    NSLog(@"[get] apikey: %@", apikey);
    return apikey;
}

+ (void) setApikey: (NSString*) apikey {
    [apikey writeToFile:[ApikeyDB getFilename]
             atomically:NO
               encoding:NSStringEncodingConversionAllowLossy
                  error:nil];
    NSLog(@"[set] apikey: %@", apikey);
}

+ (NSString*) getFilename {
    NSArray *paths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    //make a file name to write the data to using the documents directory:
    NSString *fileName = [NSString stringWithFormat:@"%@/apikey.txt",
                          documentsDirectory];
    return fileName;
}
@end

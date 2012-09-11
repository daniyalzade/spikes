//
//  CBAppDelegate.h
//  spikes
//
//  Created by eytan on 9/11/12.
//  Copyright (c) 2012 chartbeat. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CBViewController;

@interface CBAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) CBViewController *viewController;

@end

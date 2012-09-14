//
//  CBViewController.h
//  spikes
//
//  Created by eytan on 9/11/12.
//  Copyright (c) 2012 chartbeat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CBViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

#define NUM_CHARS_IN_CELL 35
@property (nonatomic) NSString *domain;
@property (weak, nonatomic) IBOutlet UITableView *spikesTVC;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@end

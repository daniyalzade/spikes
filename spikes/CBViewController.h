//
//  CBViewController.h
//  spikes
//
//  Created by eytan on 9/11/12.
//  Copyright (c) 2012 chartbeat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CBViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) NSString *domain;
@property (weak, nonatomic) IBOutlet UITableView *spikesTVC;

@end

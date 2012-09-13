//
//  CBViewController.m
//  spikes
//
//  Created by eytan on 9/11/12.
//  Copyright (c) 2012 chartbeat. All rights reserved.
//

#import "CBViewController.h"
#import "IIViewDeckController.h"
#import "SettingsViewController.h"
#import "CBServer.h"
#import "CBSpikeItemCell.h"

@interface CBViewController ()

@property (nonatomic) NSArray *spikes;

@end

@implementation CBViewController

@synthesize domain = _domain;
@synthesize spikes = _spikes;

- (void)viewDidLoad
{
    [super viewDidLoad];
    UINib *nib = [UINib nibWithNibName:@"CBSpikeItemCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"CBSpikeItemCell"];
	// Do any additional setup after loading the view, typically from a nib.
    UIImage *buttonImage = [UIImage imageNamed:@"menu.png"];
    UIImage *settingsImage = [UIImage imageNamed:@"settings.png"];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"left" style:UIBarButtonItemStyleBordered target:self.viewDeckController action:@selector(toggleLeftView)];
    [self.navigationItem.leftBarButtonItem setImage:buttonImage];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"right" style:UIBarButtonItemStyleBordered target:self action:@selector(loadSettingsVC)];
    [self.navigationItem.rightBarButtonItem setImage: settingsImage];
    if (self.domain) {
        NSLog(@"domain %@", self.domain);
        self.spikes = [[CBServer getInstance] getSpikes:self.domain];
    } else {
        [[CBServer getInstance] updateDomains];
    }
}

- (void) setDomain: (NSString *)domain {
    _domain = domain;
    CBServer *server = [CBServer getInstance];
    self.spikes = [server getSpikes:domain];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)loadSettingsVC
{
    UIViewController* settingsVC = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:nil];
    [[self navigationController] pushViewController:settingsVC animated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.spikes ? [self.spikes count] : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *spike = [self.spikes objectAtIndex:indexPath.row];
    CBSpikeItemCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"CBSpikeItemCell"];
    return cell;
}

@end

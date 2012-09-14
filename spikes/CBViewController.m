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
#import "CBWebViewController.h"
#import "CBServer.h"
#import "CBSpikeItemCell.h"

@interface CBViewController ()

@property (nonatomic) NSArray *spikes;

@end

@implementation CBViewController

@synthesize domain = _domain;
@synthesize spikesTVC = _spikesTVC;
@synthesize spinner = _spinner;
@synthesize spikes = _spikes;

- (void)viewDidLoad
{
    [super viewDidLoad];
    UINib *nib = [UINib nibWithNibName:@"CBSpikeItemCell" bundle:nil];
    [self.spikesTVC registerNib:nib forCellReuseIdentifier:@"CBSpikeItemCell"];
    [self.spikesTVC setDelegate:self];
    [self.spikesTVC setDataSource:self];

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
    NSLog(@"set domain: %@", domain);
    _domain = domain;
    CBServer *server = [CBServer getInstance];
    [_spinner startAnimating];
    dispatch_queue_t fetchQueue = dispatch_queue_create("Server Queue", NULL);
    dispatch_async(fetchQueue, ^{
        NSArray *spikes = [server getSpikes:domain];
        NSMutableArray *dedupedSpikes = [[NSMutableArray alloc] init];
        NSMutableSet* existingPaths = [NSMutableSet set];
        for (id spike in spikes) {
            if (![existingPaths containsObject:[spike objectForKey:(@"path")]]) {
                [existingPaths addObject:[spike objectForKey:(@"path")]];
                [dedupedSpikes addObject:spike];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            self.spikes = dedupedSpikes;
            [self.spikesTVC reloadData];
            [_spinner stopAnimating];
        });
    });
}

- (void)viewDidUnload
{
    [self setSpikesTVC:nil];
    [self setSpinner:nil];
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
    NSLog(@"num rows: %@", self.spikes);
    return self.spikes ? [self.spikes count] : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CBSpikeItemCell *cell = [self.spikesTVC dequeueReusableCellWithIdentifier:@"CBSpikeItemCell"];
    NSDictionary *spike = [_spikes objectAtIndex:indexPath.row];
    NSString *title = [spike objectForKey:(@"title")];
    if ([title length] > NUM_CHARS_IN_CELL) {
        title = [[title substringToIndex:NUM_CHARS_IN_CELL] stringByAppendingString:@"..."];
    }
    [cell.spikeLabel setText:title];
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *spike = [_spikes objectAtIndex:indexPath.row];
    NSString *path = [spike objectForKey:(@"path")];
    CBWebViewController *webViewVC = [[CBWebViewController alloc] initWithNibName:@"CBWebViewController" bundle:nil];
    NSLog(@"navigating to path %@", path);
    /* Handle Subdomains */
    if ([path rangeOfString:_domain].location == NSNotFound) {
        path = [_domain stringByAppendingString:path];
    }
    webViewVC.path = [@"http://" stringByAppendingString:path];
    [[self navigationController] pushViewController:webViewVC animated:NO];
}

@end

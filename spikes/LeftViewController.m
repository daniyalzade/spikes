//
//  LeftViewController.m
//  spikes
//
//  Created by eytan on 9/11/12.
//  Copyright (c) 2012 chartbeat. All rights reserved.
//

#import "LeftViewController.h"
#import "IIViewDeckController.h"
#import "CBServer.h"
#import "CBDomainItemCell.h"
#import "CBViewController.h"

@interface LeftViewController ()

@property (weak, nonatomic) IBOutlet UITableView *domainsTVC;

@end

@implementation LeftViewController
@synthesize domainsTVC;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UINib *nib = [UINib nibWithNibName:@"CBDomainItemCell" bundle:nil];
    // Register this NIB which contains the cell
    [[self domainsTVC] registerNib:nib forCellReuseIdentifier:@"CBDomainItemCell"];
    [self.domainsTVC setDelegate:self];
    [self.domainsTVC setDataSource:self];
}

- (void)viewDidUnload
{
    [self setDomainsTVC:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[CBServer getInstance] getDomains] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CBDomainItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CBDomainItemCell"];
    NSString *domain = [[[CBServer getInstance] getDomains] objectAtIndex:indexPath.row];
    cell.domainName.text = domain;
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *domain = [[[CBServer getInstance] getDomains] objectAtIndex:indexPath.row];
    CBViewController *cbView = (CBViewController *) ((UINavigationController*) self.viewDeckController.centerController).topViewController;
    cbView.domain = domain;
    [self.viewDeckController toggleLeftView];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


@end

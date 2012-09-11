//
//  SettingsViewController.m
//  spikes
//
//  Created by eytan on 9/11/12.
//  Copyright (c) 2012 chartbeat. All rights reserved.
//

#import "SettingsViewController.h"
#import "ApikeyDB.h"

@interface SettingsViewController ()

@property (weak, nonatomic) IBOutlet UITextField *apiKeyField;

@end

@implementation SettingsViewController
@synthesize apiKeyField;

- (IBAction)onSettingsSubmitted:(id)sender {
    NSString* apikey = self.apiKeyField.text;
    NSLog(@"apikey: %@", apikey);
    [ApikeyDB setApikey:apikey];
}

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
}

- (void)viewDidUnload
{
    [self setApiKeyField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end

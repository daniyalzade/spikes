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

@end

@implementation SettingsViewController

@synthesize apiKeyField;

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
    [apiKeyField setDelegate:self];
    [apiKeyField setReturnKeyType:UIReturnKeyDone];
    [apiKeyField addTarget:self
                       action:@selector(textFieldFinished:)
             forControlEvents:UIControlEventEditingDidEndOnExit];

    [apiKeyField setText:[ApikeyDB getApikey]];
    // Do any additional setup after loading the view from its nib.
    [super viewDidLoad];
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

- (IBAction)textFieldFinished:(id)sender
{
    NSString* apikey = self.apiKeyField.text;
    [ApikeyDB setApikey:apikey];
}
@end

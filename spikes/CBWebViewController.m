//
//  CBWebViewController.m
//  spikes
//
//  Created by eytan on 9/14/12.
//  Copyright (c) 2012 chartbeat. All rights reserved.
//

#import "CBWebViewController.h"

@interface CBWebViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *uiWebView;

@end

@implementation CBWebViewController
@synthesize uiWebView = _uiWebView;
@synthesize path = _path;

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
    NSURL *url = [NSURL URLWithString:_path];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [_uiWebView loadRequest:requestObj];
}

- (void)viewDidUnload
{
    [self setUiWebView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end

//
//  COTWebView.m
//  CashOut
//
//  Created by Rick on 11/14/12.
//  Copyright (c) 2012 Rick. All rights reserved.
//

#import "COTWebView.h"

@interface COTWebView ()
@property (nonatomic,weak) IBOutlet UIWebView *webView;
@end

@implementation COTWebView
@synthesize webView = _webView;

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.webView.scalesPageToFit = YES;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.google.com"]]];
}
-(BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}


@end

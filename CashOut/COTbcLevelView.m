//
//  COTbcLevelView.m
//  CashOut
//
//  Created by Rick on 11/7/12.
//  Copyright (c) 2012 Rick. All rights reserved.
//

#import "COTbcLevelView.h"

@interface COTbcLevelView ()

@end

@implementation COTbcLevelView

-(void)selectLevel:(id)sender
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    //Get level value from button label
    NSString *title = [[sender titleLabel] text];
    
    //Change to NSNumber from NSString, print to log again
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber * myNumber = [f numberFromString:title];

    [standardUserDefaults setObject:myNumber forKey:@"bclevel"];
    [standardUserDefaults synchronize];
    
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
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

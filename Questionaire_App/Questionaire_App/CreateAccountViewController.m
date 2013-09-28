//
//  CreateAccountViewController.m
//  Questionaire_App
//
//  Created by Andrew Kelley on 9/28/13.
//  Copyright (c) 2013 Tucker Cozzens. All rights reserved.
//

#import "CreateAccountViewController.h"

@interface CreateAccountViewController ()

@end

@implementation CreateAccountViewController
@synthesize userName, password, confirmPassword;

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submit:(id)sender
{
    NSLog(@"Clicked: %@. Username: %@, Password: %@", [(UIButton *)sender currentTitle], [(UITextField *)userName text], [(UITextField *)password text]);
    [self dismissViewControllerAnimated:TRUE completion:nil];
}

@end

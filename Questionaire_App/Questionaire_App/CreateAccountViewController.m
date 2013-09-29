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
@synthesize userName, password, confirmPassword, error;

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


- (IBAction)submit:(id)sender
{
    if (![[(UITextField *)userName text] isEqualToString:@""]) {
    
        if ([self checkPasswordsMatch:[(UITextField *)password text]
                                     :[(UITextField *)confirmPassword text]]) {
            if ([self checkPasswordsNotNull:[(UITextField *)password text]
                                           :[(UITextField *)confirmPassword text]]) {
                [self setErrorMessage:@"Passwords cannot be empty"];
            } else{
                [self dismissViewControllerAnimated:TRUE completion:nil];
            }
        } else {
            [self setErrorMessage:@"Passwords do not match please try again"];
        }
    } else {
        [self setErrorMessage:@"Please enter a username"];
    }
}

- (Boolean)checkPasswordsMatch:(NSString *)password1 :(NSString *)password2
{
    return [password1 isEqualToString:password2];
}

- (Boolean)checkPasswordsNotNull:(NSString *)password1 :(NSString *)password2
{
    return [password1 isEqualToString: @""] && [password2 isEqualToString: @""];
}

- (void)setErrorMessage:(NSString *)message
{
    [(UITextField *)confirmPassword resignFirstResponder];
    [(UILabel *)error setText:message];
    [(UILabel *)error setHidden:false];
    [(UITextField *)password setText:@""];
    [(UITextField *)confirmPassword setText:@""];
}

@end

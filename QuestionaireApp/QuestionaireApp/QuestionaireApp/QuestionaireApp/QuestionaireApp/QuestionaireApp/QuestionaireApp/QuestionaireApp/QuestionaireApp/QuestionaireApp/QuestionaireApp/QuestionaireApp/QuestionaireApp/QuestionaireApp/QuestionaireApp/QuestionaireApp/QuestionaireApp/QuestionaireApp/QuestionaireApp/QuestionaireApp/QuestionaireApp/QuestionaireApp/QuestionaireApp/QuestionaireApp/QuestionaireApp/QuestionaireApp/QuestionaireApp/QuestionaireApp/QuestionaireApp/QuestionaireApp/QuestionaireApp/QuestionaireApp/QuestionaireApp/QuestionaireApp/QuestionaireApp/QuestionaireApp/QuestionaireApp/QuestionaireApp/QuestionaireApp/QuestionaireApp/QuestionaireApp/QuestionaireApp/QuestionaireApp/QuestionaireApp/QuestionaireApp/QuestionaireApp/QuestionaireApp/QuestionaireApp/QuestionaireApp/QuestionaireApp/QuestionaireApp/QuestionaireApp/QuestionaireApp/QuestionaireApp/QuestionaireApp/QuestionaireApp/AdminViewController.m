//
//  AdminViewController.m
//  QuestionaireApp
//
//  Created by Andrew Kelley on 10/3/13.
//  Copyright (c) 2013 Tucker Cozzens. All rights reserved.
//

#import "AdminViewController.h"
#import "User.h"

@interface AdminViewController ()

@end

@implementation AdminViewController

@synthesize adminUsername, password, patientId, error;

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
    if ([[(UITextField *)adminUsername text] isEqualToString:@""]) {
        if ([self checkPasswordsNotNull:[(UITextField *)password text]]) {
            [self setErrorMessage:@"Please enter a password"];
        } else {
            [self dismissViewControllerAnimated:TRUE completion:nil];
        }
    } else {
        [self setErrorMessage:@"Please enter a username"];
    }
    
    //need to do an error check before do the login
    [self authenticateUser];
}

- (Boolean)checkPasswordsNotNull:(NSString *)password1
{
    return [password1 isEqualToString: @""];
}

- (void)setErrorMessage:(NSString *)message
{
    [(UITextField *)password resignFirstResponder];
    [(UILabel *)error setText:message];
    [(UILabel *)error setHidden:false];
    [(UITextField *)password setText:@""];
}

- (void) authenticateUser{
    User *user = [[User alloc] init];
    [user authenticateWithPatientId:[patientId text]
                           Username:[adminUsername text]
                           Password:[password text]];
}

-(IBAction)backgroundTapped:(id)sender
{
    // Dismisses keyboard
    [self.view endEditing:YES];
}

@end

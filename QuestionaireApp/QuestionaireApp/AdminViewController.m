//
//  AdminViewController.m
//  QuestionaireApp
//
//  Created by Andrew Kelley on 10/3/13.
//  Copyright (c) 2013 Tucker Cozzens. All rights reserved.
//

#import "AdminViewController.h"
#import "AFHTTPRequestOperationManager.h"

@interface AdminViewController ()

@property (strong) AFHTTPRequestOperationManager *manager;

@end

@implementation AdminViewController

@synthesize adminUsername, password, patientId, error;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.manager = [AFHTTPRequestOperationManager manager];
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
    if (![[(UITextField *)adminUsername text] isEqualToString:@""]) {
        if ([self checkPasswordsNotNull:[(UITextField *)password text]]) {
            [self setErrorMessage:@"Please enter a password"];
        } else {
            [self authenticateUser];
        }
    } else {
        [self setErrorMessage:@"Please enter a username"];
    }
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
    
    NSString *URLString = @"http://capstone-f13.herokuapp.com/oauth2/access_token";
    
    NSString *usernameString = [adminUsername text];
    NSString *passwordString = [password text];
    
    NSDictionary *parameters = @{@"client_id" : @"b2ad60956a2ef2ff6eb8",
                                 @"client_secret" : @"d228f55610c14fe620e1e0bea9708e22988d0f1d",
                                 @"grant_type" : @"password",
                                 @"username" : usernameString,
                                 @"password" : passwordString,
                                 @"scope" : @"write"
                                 };
    
    AFHTTPRequestOperation *operation = [self.manager POST:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {

        NSString *token = [(NSDictionary *)responseObject objectForKey:@"access_token"];
        
        [self.manager GET:[NSString stringWithFormat:@"http://capstone-f13.herokuapp.com/patients/%@",token] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

            NSLog(@"JSON : %@",responseObject);
            
            NSString *patientID = [(NSArray *)[(NSDictionary *)responseObject objectForKey:@"patient_ids"] objectAtIndex:1];

            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:token forKey:@"autoToken"];
            [defaults setObject:patientID forKey:@"patientID"];
            [defaults synchronize];
            
            [self.navigationController popViewControllerAnimated:YES];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *localError) {

            NSLog(@"Error: %@", localError);

        }];

    } failure:^(AFHTTPRequestOperation *operation, NSError *localError) {
        
        NSLog(@"Error: %@", localError);

    }];
    
    [operation start];
}

-(IBAction)backgroundTapped:(id)sender
{
    // Dismisses keyboard
    [self.view endEditing:YES];
}

@end

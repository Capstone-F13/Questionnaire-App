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
@property (nonatomic) NSString *serverURLString;

@end

@implementation AdminViewController

@synthesize adminUsername, password, error;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        
        
        // TODO: Make this disable the button
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if (![defaults objectForKey:@"authToken"] || ![defaults objectForKey:@"patientID"]) {
            self.cancelButton.enabled = NO;
        }
        
        _manager = [AFHTTPRequestOperationManager manager];
        _serverURLString = @"http://create.cs.kent.edu/oauth2/access_token";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)submit:(id)sender
{
    if (![adminUsername text] || [[adminUsername text] isEqualToString:@""]) {
        [self setErrorMessage:@"Please enter a username"];
        return;
    }
    
    if (![password text] || [[password text] isEqualToString:@""]) {
        [self setErrorMessage:@"Please enter a password"];
        return;
    }
    
    [self authenticateUser];
}

- (void)setErrorMessage:(NSString *)message
{
    [(UITextField *)password resignFirstResponder];
    [(UILabel *)error setText:message];
    [(UILabel *)error setHidden:false];
    [(UITextField *)password setText:@""];
}

- (void) authenticateUser{
    
    NSString *usernameString = [adminUsername text];
    NSString *passwordString = [password text];
    
    NSDictionary *parameters = @{@"client_id" : @"19338b8cd902c96dc495",
                                 @"client_secret" : @"b2faeb98ba2cf71f53e7045ad0b30782a65a148a",
                                 @"grant_type" : @"password",
                                 @"username" : usernameString,
                                 @"password" : passwordString,
                                 @"scope" : @"write"
                                 };
    
    
    __weak AdminViewController *weakSelf = self;
    
    [self.manager POST:self.serverURLString
            parameters:parameters
               success:^(AFHTTPRequestOperation *operation, id responseObject) {
                   
                   NSLog(@"%@", responseObject);
                   NSString *token = [(NSDictionary *)responseObject objectForKey:@"access_token"];
                   
                   [weakSelf.manager GET:[NSString stringWithFormat:@"http://create.cs.kent.edu/patients/%@", token]
                              parameters:nil
                                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                     
                                     NSLog(@"JSON : %@",responseObject);
                                     
                                     NSArray *patients = (NSArray *)[(NSDictionary *)responseObject objectForKey:@"patient_ids"];
                                     
                                     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                                     [defaults setObject:token forKey:@"authToken"];
                                     [defaults setObject:patients forKey:@"patients"];
                                     [defaults synchronize];
                                     
                                     [self performSegueWithIdentifier:@"AdminToPatientsSegue" sender:self];
                                     
                                 } failure:^(AFHTTPRequestOperation *operation, NSError *localError) {
                                     
                                     NSLog(@"Error: %@", localError);
                                     
                                 }];
                   
               } failure:^(AFHTTPRequestOperation *operation, NSError *localError) {
                   
                   NSLog(@"Error: %@", localError);
                   
               }];
}

-(IBAction)backgroundTapped:(id)sender
{
    // Dismisses keyboard
    [self.view endEditing:YES];
}

- (IBAction)adminCancel:(id)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults objectForKey:@"authToken"] || ![defaults objectForKey:@"patientID"]) {
        return;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

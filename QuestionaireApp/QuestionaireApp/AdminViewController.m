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

bool adminLoginRepositioned = false;
CGRect usernameContainerPortraitPosition;
CGRect passwordContainerPortraitPosition;

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
        self.manager = [AFHTTPRequestOperationManager manager];
        _serverURLString = @"http://create.cs.kent.edu/oauth2/access_token";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Register for device rotation notifications
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(orientationChanged:)
     name:UIDeviceOrientationDidChangeNotification
     object:[UIDevice currentDevice]];
    
    [self savePortraitViewPositions];
    
    // Adjust play and stop buttons as necessary
    UIDevice *device = [UIDevice currentDevice];
    if (device.orientation == UIDeviceOrientationLandscapeLeft || device.orientation == UIDeviceOrientationLandscapeRight)
    {
        usernameContainer.frame = CGRectOffset(usernameContainer.frame, 0, -5);
        passwordContainer.frame = CGRectOffset(passwordContainer.frame, 0, -85);
        adminLoginRepositioned = true;
    }
    else if (device.orientation == UIDeviceOrientationPortrait)
    {
        [self setPortraitViewPositions];
    }
}

- (void)orientationChanged:(NSNotification *)note
{
    UIDevice * device = note.object;
    // Adjusts play and stop buttons as necessary
    switch(device.orientation)
    {
        case UIDeviceOrientationPortrait:
            [self setPortraitViewPositions];
            break;
        case UIDeviceOrientationLandscapeLeft:
            [self setLandscapeViewPositions];
            break;
        case UIDeviceOrientationLandscapeRight:
            [self setLandscapeViewPositions];
            break;
            
        default:
            break;
    };
}

- (void)savePortraitViewPositions
{
    usernameContainerPortraitPosition = CGRectMake(60, 103, 201, 69);
    passwordContainerPortraitPosition = CGRectMake(60, 185, 201, 69);
}

- (void)setPortraitViewPositions
{
    usernameContainer.frame = usernameContainerPortraitPosition;
    passwordContainer.frame = passwordContainerPortraitPosition;
    adminLoginRepositioned = false;
}

- (void)setLandscapeViewPositions
{
    if (!adminLoginRepositioned)
    {
        usernameContainer.frame = CGRectOffset(usernameContainer.frame, 0, -5);
        passwordContainer.frame = CGRectOffset(passwordContainer.frame, 0, -85);
        adminLoginRepositioned = true;
    }
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
    
    NSString *usernameString = [adminUsername text];
    NSString *passwordString = [password text];
    
    NSDictionary *parameters = @{@"client_id" : @"19338b8cd902c96dc495",
                                 @"client_secret" : @"b2faeb98ba2cf71f53e7045ad0b30782a65a148a",
                                 @"grant_type" : @"password",
                                 @"username" : usernameString,
                                 @"password" : passwordString,
                                 @"scope" : @"write"
                                 };
    
    AFHTTPRequestOperation *operation = [self.manager POST:self.serverURLString
                                                parameters:parameters
        success:^(AFHTTPRequestOperation *operation, id responseObject) {

            NSLog(@"%@", responseObject);
            NSString *token = [(NSDictionary *)responseObject objectForKey:@"access_token"];
        
            [self.manager GET:[NSString stringWithFormat:@"http://create.cs.kent.edu/patients/%@", token]
                   parameters:nil
                      success:^(AFHTTPRequestOperation *operation, id responseObject) {

                          NSLog(@"JSON : %@",responseObject);
            
                          NSArray *patients = (NSArray *)[(NSDictionary *)responseObject objectForKey:@"patient_ids"];

                          NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                          [defaults setObject:token forKey:@"autoToken"];
                          [defaults setObject:patients forKey:@"patients"];
                          [defaults synchronize];
            
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

- (IBAction)adminCancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

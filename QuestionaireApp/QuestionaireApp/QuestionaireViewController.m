//
//  QuestionaireViewController.m
//  QuestionaireApp
//
//  Created by Tucker Cozzens on 10/2/13.
//  Copyright (c) 2013 Tucker Cozzens. All rights reserved.
//

#import "QuestionaireViewController.h"
#import "AFHTTPRequestOperationManager.h"

@interface QuestionaireViewController ()

@property (strong) AFHTTPRequestOperationManager *manager;

@end

@implementation QuestionaireViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //[self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.0/255.0 green:51.0/255.0 blue:152.0/255.0 alpha:1.0]];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults objectForKey:@"authToken"] || ![defaults objectForKey:@"patientID"]) {
        [self performSegueWithIdentifier:@"MainMenuToAdminSegue" sender:self];
    }
	
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)logout:(id)sender {
    
    self.manager = [AFHTTPRequestOperationManager manager];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *URLString = @"http://create.cs.kent.edu/patient/logout";
    NSString *token = [defaults stringForKey:@"authToken"];
    NSString *patientID = [defaults stringForKey:@"patientID"];
    
    NSDictionary *parameters = @{@"access_token" : token,
                                 @"patient_id" : patientID
                                 };
    
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST"
                                                                                 URLString:URLString
                                                                                parameters:parameters];
    
    AFHTTPRequestOperation *operation = [self.manager HTTPRequestOperationWithRequest:request
                                                                              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                                                  
                                                                                  [defaults removeObjectForKey:@"authToken"];
                                                                                  [defaults removeObjectForKey:@"patientID"];
                                                                                  [defaults synchronize];
                                                                                  
                                                                                  [self performSegueWithIdentifier:@"MainMenuToAdminSegue" sender:self];
                                                                                  
                                                                              } failure:^(AFHTTPRequestOperation *operation, NSError *localError) {
                                                                                  
                                                                                  NSLog(@"Error: %@", localError);
                                                                                  NSLog(@"%@", operation.request);
                                                                                  
                                                                              }];
    
    [operation start];
    
}

@end

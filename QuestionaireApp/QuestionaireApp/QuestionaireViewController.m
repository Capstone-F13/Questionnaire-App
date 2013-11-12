//
//  QuestionaireViewController.m
//  QuestionaireApp
//
//  Created by Tucker Cozzens on 10/2/13.
//  Copyright (c) 2013 Tucker Cozzens. All rights reserved.
//

#import "QuestionaireViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "Constants.h"

@interface QuestionaireViewController ()

@property (strong) AFHTTPRequestOperationManager *manager;

@end

@implementation QuestionaireViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //[self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.0/255.0 green:51.0/255.0 blue:152.0/255.0 alpha:1.0]];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults objectForKey:DEFAULTS_AUTH_TOKEN] || ![defaults objectForKey:DEFAULTS_PATIENT_ID]) {
        [self performSegueWithIdentifier:@"MainMenuToAdminSegue" sender:self];
    }
    
    self.manager = [AFHTTPRequestOperationManager manager];
	
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated {
    __block BOOL checkedStatus = NO;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (!checkedStatus) {
            checkedStatus = YES;
            switch (status) {
                case AFNetworkReachabilityStatusReachableViaWWAN:
                case AFNetworkReachabilityStatusReachableViaWiFi: {
                    
                    NSLog(@"reachable --> questionnaire view controller");
                    
                    NSMutableArray *mutableOperations = [NSMutableArray array];
                    
                    NSArray *parametersArray = [defaults arrayForKey:DEFAULTS_PARAMETERS_ARRAY];
                    if (parametersArray) {
                        for (NSDictionary *parameters in parametersArray) {
                            
                            NSString *URLString = [NSString stringWithFormat: @"%@/answer/", SERVER_ADDRESS];
                            NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:URLString parameters:parameters];
                            
                            AFHTTPRequestOperation *operation = [self.manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                
                                NSLog(@"JSON: %@",responseObject);
                                
                            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                
                                NSLog(@"Error: %@", error);
                                
                            }];
                            
                            [mutableOperations addObject:operation];
                        }
                        
                        NSArray *operations = [AFURLConnectionOperation batchOfRequestOperations:mutableOperations progressBlock:^(NSUInteger numberOfFinishedOperations, NSUInteger totalNumberOfOperations) {
                            
                            NSLog(@"%lu of %lu complete", (long)numberOfFinishedOperations, (long)totalNumberOfOperations);
                            
                        } completionBlock:^(NSArray *operations) {
                            
                            [defaults setObject:[NSArray new] forKey:DEFAULTS_PARAMETERS_ARRAY];
                            
                            NSLog(@"All operations in batch complete");
                        }];
                        
                        [[NSOperationQueue mainQueue] addOperations:operations waitUntilFinished:NO];
                    }
                }
                case AFNetworkReachabilityStatusNotReachable:
                default: {
                    
                    NSLog(@"not reachable --> questionnaire view controller");
                    
                    break;
                }
            }
        }
    }];
    
    [manager startMonitoring];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)logout:(id)sender {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *URLString = [NSString stringWithFormat: @"%@/patient/logout", SERVER_ADDRESS];
    NSString *token = [defaults stringForKey:DEFAULTS_AUTH_TOKEN];
    NSString *patientID = [defaults stringForKey:DEFAULTS_PATIENT_ID];
    
    NSDictionary *parameters = @{@"access_token" : token,
                                 @"patient_id" : patientID
                                 };
    
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST"
                                                                                 URLString:URLString
                                                                                parameters:parameters];
    
    AFHTTPRequestOperation *operation = [self.manager HTTPRequestOperationWithRequest:request
                                                                              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                                                  
                                                                                  [defaults removeObjectForKey:DEFAULTS_AUTH_TOKEN];
                                                                                  [defaults removeObjectForKey:DEFAULTS_PATIENT_ID];
                                                                                  [defaults synchronize];
                                                                                  
                                                                                  [self performSegueWithIdentifier:@"MainMenuToAdminSegue" sender:self];
                                                                                  
                                                                              } failure:^(AFHTTPRequestOperation *operation, NSError *localError) {
                                                                                  
                                                                                  NSLog(@"Error: %@", localError);
                                                                                  NSLog(@"%@", operation.request);
                                                                                  
                                                                              }];
    
    [operation start];
    
}

- (IBAction)takeSurvey:(id)sender {

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

//    double currentTime = [[[NSDate alloc] init] timeIntervalSince1970];
//    double sentTime = [defaults doubleForKey:DEFAULTS_TIME_SURVEY_SENT];
//    double timeWaited = currentTime - sentTime;
//    
//    if (timeWaited < MINIMUM_WAIT_FOR_NEXT_SURVEY) {
//   
//        NSString *waitMessage = nil;
//        
//        int minutes = (MINIMUM_WAIT_FOR_NEXT_SURVEY - timeWaited) / 60;
//        
//        if (minutes > 1) {
//            waitMessage = [NSString stringWithFormat:@"The survey will be available in %d minutes",minutes];
//        }
//        else if (minutes == 1) {
//            waitMessage = [NSString stringWithFormat:@"The survey will be available in 1 minute"];
//        }
//        else {
//            waitMessage = [NSString stringWithFormat:@"The survey will be available in less than a minute"];
//        }
//        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"The app is currently updating"
//                                                        message:waitMessage
//                                                       delegate:self
//                                              cancelButtonTitle:@"OK"
//                                              otherButtonTitles:nil];
//        [alert show];
//        
//        return;
//    }

    __block BOOL checkedStatus = NO;
    
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (!checkedStatus) {
            checkedStatus = YES;
            switch (status) {
                case AFNetworkReachabilityStatusReachableViaWWAN:
                case AFNetworkReachabilityStatusReachableViaWiFi: {
                    
                    NSLog(@"reachable --> take survey in questionnaire view controller");
                    
                    NSString *authToken = [defaults stringForKey:DEFAULTS_AUTH_TOKEN];
                    NSString *patientID = [defaults stringForKey:DEFAULTS_PATIENT_ID];
                    NSString *questionsURL = [NSString stringWithFormat:@"%@/questions/%@/%@", SERVER_ADDRESS, authToken, patientID];
                    
                    [self.manager GET:questionsURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                        
                        [defaults setObject:responseObject forKey:DEFAULTS_CURRENT_SURVEY];
                        
                        [self performSegueWithIdentifier:@"MainMenuToSurveySegue" sender:self];
                        
                    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                        
                        NSLog(@"Error: %@", error);
                        
                    }];
                    
                    break;
                }
                    
                case AFNetworkReachabilityStatusNotReachable:
                default: {

                    NSLog(@"not reachable --> take survey in questionnaire view controller");
                    
                    id storedSurvey = [defaults objectForKey:DEFAULTS_CURRENT_SURVEY];
                    
                    if (storedSurvey) {
                        [self performSegueWithIdentifier:@"MainMenuToSurveySegue" sender:self];
                    }
                    else {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No internet"
                                                                        message:@"Please try again once you have internet access. Thanks!"
                                                                       delegate:self
                                                              cancelButtonTitle:@"OK"
                                                              otherButtonTitles:nil];
                        [alert show];
                    }
                    
                    break;
                }
            }
        }
    }];
    
    [manager startMonitoring];
}

@end

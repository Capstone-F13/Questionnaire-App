//
//  PatientsViewController.m
//  QuestionaireApp
//
//  Created by Mohammad Doleh on 10/23/13.
//  Copyright (c) 2013 Tucker Cozzens. All rights reserved.
//

#import "PatientsViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "Constants.h"

@interface PatientsViewController ()

@property (strong) AFHTTPRequestOperationManager *manager;
@property (nonatomic, retain) NSArray *patients;

@end

@implementation PatientsViewController

@synthesize patientTable;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.navigationItem.hidesBackButton = YES;
        
        self.manager = [AFHTTPRequestOperationManager manager];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        self.patients = [defaults arrayForKey:DEFAULTS_PATIENTS];
        
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.patients count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"patientCell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"patientCell"];
    }
    
    cell.textLabel.text = [self.patients objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *patientIDURL = [NSString stringWithFormat: @"%@/patient/login", SERVER_ADDRESS];
    NSString *token = [defaults stringForKey:DEFAULTS_AUTH_TOKEN];
    NSString *patientId = [NSString stringWithFormat:@"%@", [self.patients objectAtIndex:indexPath.row] ];
    
    NSDictionary *parameters = @{@"access_token" : token,
                                 @"patient_id" : patientId
                                 };
    
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST"
                                                                                 URLString:patientIDURL
                                                                                parameters:parameters];
    
    AFHTTPRequestOperation *operation = [self.manager HTTPRequestOperationWithRequest:request
                                                                              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                                                  
                                                                                  // Success
                                                                                  if([responseObject valueForKey:@"success"] != nil){
                                                                                      
                                                                                      NSLog(@"%@", responseObject);
                                                                                      [defaults setObject:patientId forKey:DEFAULTS_PATIENT_ID];
                                                                                      [defaults synchronize];
                                                                                      
                                                                                      [self dismissViewControllerAnimated:YES completion:nil];
                                                                                      
                                                                                      [self registerForNotifications];
                                                                                      
                                                                                  }
                                                                                  
                                                                                  // Error
                                                                                  else {
                                                                                      NSLog(@"Error: %@", [responseObject valueForKey:@"error"]);
                                                                                  }
                                                                                  
                                                                              } failure:^(AFHTTPRequestOperation *operation, NSError *localError) {
                                                                                  
                                                                                  NSLog(@"Error: %@", localError);
                                                                                  
                                                                              }];
    
    [operation start];
}

- (IBAction)addPatient:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Enter Patient ID"
                                                    message:@""
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"Add",nil];
    
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        NSString *patientIDURL = [NSString stringWithFormat: @"%@/patient/create", SERVER_ADDRESS];
        NSString *token = [defaults stringForKey:DEFAULTS_AUTH_TOKEN];
        NSString *patientID = [alertView textFieldAtIndex:0].text;
        
        NSLog(@"%@",patientID);
        
        NSDictionary *parameters = @{@"access_token" : token,
                                     @"patient_id" : patientID,
                                     };
        
        NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST"
                                                                                     URLString:patientIDURL
                                                                                    parameters:parameters];
        
        AFHTTPRequestOperation *operation = [self.manager HTTPRequestOperationWithRequest:request
                                                                                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                                                      
                                                                                      // Success
                                                                                      if([responseObject valueForKey:@"success"] != nil){
                                                                                          
                                                                                          NSLog(@"%@", responseObject);
                                                                                          [defaults setObject:patientID forKey:DEFAULTS_PATIENT_ID];
                                                                                          [defaults synchronize];
                                                                                          [defaults setDouble:0 forKey:DEFAULTS_TIME_SURVEY_SENT];
                                                                                          
                                                                                          [self dismissViewControllerAnimated:YES completion:nil];
                                                                                          
                                                                                      }
                                                                                      
                                                                                      // Error
                                                                                      else {
                                                                                          NSLog(@"Error: %@", [responseObject valueForKey:@"error"]);
                                                                                      }
                                                                                      
                                                                                  } failure:^(AFHTTPRequestOperation *operation, NSError *localError) {
                                                                                      
                                                                                      NSLog(@"Error: %@", localError);
                                                                                      
                                                                                  }
                                             ];
        
        [operation start];
    }
}

- (void)registerForNotifications
{
    if (!REGISTER_FOR_NOTIFICATIONS) {
        NSDate *currentDate = [NSDate date];
        NSCalendar* calendar = [NSCalendar currentCalendar];
        NSDateComponents* components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:currentDate]; // Get necessary date components
        [components setHour: 16];
        [components setMinute: 25];
        [components setSecond: 0];
        [calendar setTimeZone: [NSTimeZone defaultTimeZone]];
        NSDate *dateToFire = [calendar dateFromComponents:components];
        
        UILocalNotification* localNotification = [[UILocalNotification alloc] init];
        localNotification.alertBody = @"Time to take the survey";
        [localNotification setFireDate: dateToFire];
        [localNotification setTimeZone: [NSTimeZone defaultTimeZone]];
        [localNotification setRepeatInterval: NSDayCalendarUnit];
        // Let the device know we want to receive push notifications
        
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
        
        currentDate = [NSDate date];
        calendar = [NSCalendar currentCalendar];
        components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:currentDate]; // Get necessary date components
        [components setHour: 18];
        [components setMinute: 30];
        [components setSecond: 0];
        [calendar setTimeZone: [NSTimeZone defaultTimeZone]];
        dateToFire = [calendar dateFromComponents:components];
        
        localNotification = [[UILocalNotification alloc] init];
        localNotification.alertBody = @"Time to take the survey";
        [localNotification setFireDate: dateToFire];
        [localNotification setTimeZone: [NSTimeZone defaultTimeZone]];
        [localNotification setRepeatInterval: NSDayCalendarUnit];
        // Let the device know we want to receive push notifications
        
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
        
        currentDate = [NSDate date];
        calendar = [NSCalendar currentCalendar];
        components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:currentDate]; // Get necessary date components
        [components setHour: 20];
        [components setMinute: 55];
        [components setSecond: 0];
        [calendar setTimeZone: [NSTimeZone defaultTimeZone]];
        dateToFire = [calendar dateFromComponents:components];
        
        localNotification = [[UILocalNotification alloc] init];
        localNotification.alertBody = @"Time to take the survey";
        [localNotification setFireDate: dateToFire];
        [localNotification setTimeZone: [NSTimeZone defaultTimeZone]];
        [localNotification setRepeatInterval: NSDayCalendarUnit];
        // Let the device know we want to receive push notifications
        
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
        
        REGISTER_FOR_NOTIFICATIONS = true;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [[self patientTable] setDataSource:self];
    [[self patientTable] setDelegate:self];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

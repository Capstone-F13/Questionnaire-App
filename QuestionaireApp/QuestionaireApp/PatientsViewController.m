//
//  PatientsViewController.m
//  QuestionaireApp
//
//  Created by Mohammad Doleh on 10/23/13.
//  Copyright (c) 2013 Tucker Cozzens. All rights reserved.
//

#import "PatientsViewController.h"
#import "AFHTTPRequestOperationManager.h"

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
        self.manager = [AFHTTPRequestOperationManager manager];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        self.patients = [defaults arrayForKey:@"patients"];
        
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
    
    NSString *patientIDURL = @"http://create.cs.kent.edu/patient/login";
    NSString *token = [defaults stringForKey:@"autoToken"];
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
                [defaults setObject:patientId forKey:@"patientID"];
                [defaults synchronize];
                
                [self dismissViewControllerAnimated:YES completion:nil];
                
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

// USE THIS LINE OF CODE TO DISMISS THE VIEW AND RETURN TO THE MAIN MENU
//[self dismissViewControllerAnimated:YES completion:NULL];

@end

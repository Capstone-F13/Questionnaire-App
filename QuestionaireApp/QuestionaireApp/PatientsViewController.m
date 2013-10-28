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
        
        NSLog(@"%@ %@", [self.patients objectAtIndex:0], [self.patients objectAtIndex:1]);
        
        //[[self patientTable] initWithFrame:CGRectMake(100, 100, 200, 200) style:UITableViewStyleGrouped];
        //[[self patientTable] reloadData];
        
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
    
    NSString *patientIDURL = @"http://capstone-f13.herokuapp.com/patient/login";
    NSString *token = [defaults stringForKey:@"autoToken"];
    NSString *patientId = [self.patients objectAtIndex:indexPath.row];
 
    NSDictionary *parameters = @{@"access_token" : token,
                                 @"patient_id" : patientId
                                 };
    
    
    AFHTTPRequestOperation *operation = [self.manager POST:patientIDURL
                                                parameters:parameters
        success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                       
            NSLog(@"%@", responseObject);
            [defaults setObject:patientId forKey:@"patientID"];
            [defaults synchronize];

        } failure:^(AFHTTPRequestOperation *operation, NSError *localError) {
           
            NSLog(@"Error: %@", localError);
            NSLog(@"%@", operation);
           
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

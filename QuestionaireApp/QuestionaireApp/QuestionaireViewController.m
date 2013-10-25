//
//  QuestionaireViewController.m
//  QuestionaireApp
//
//  Created by Tucker Cozzens on 10/2/13.
//  Copyright (c) 2013 Tucker Cozzens. All rights reserved.
//

#import "QuestionaireViewController.h"

@interface QuestionaireViewController ()

@end

@implementation QuestionaireViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.0/255.0 green:51.0/255.0 blue:152.0/255.0 alpha:1.0]];
    // THIS BREAKS THE APP WHEN RUN
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    if (![defaults objectForKey:@"authToken"] || ![defaults objectForKey:@"patientID"]) {
//        [self performSegueWithIdentifier:@"MainMenuToAdminSegue" sender:self];
//    }
	
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated {
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    if (![defaults objectForKey:@"authToken"] || ![defaults objectForKey:@"patientID"]) {
//        [self performSegueWithIdentifier:@"MainMenuToAdminSegue" sender:self];
//    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

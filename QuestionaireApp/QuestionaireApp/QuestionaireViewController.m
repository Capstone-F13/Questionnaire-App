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

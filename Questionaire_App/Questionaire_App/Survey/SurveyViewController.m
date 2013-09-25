//
//  SurveyViewController.m
//  Questionaire_App
//
//  Created by Mohammad Doleh on 9/18/13.
//  Copyright (c) 2013 Tucker Cozzens. All rights reserved.
//

#import "SurveyViewController.h"

@interface SurveyViewController ()
    -(void)showAppropriateFields:(Boolean)isMultipleChoice;
    -(void)showSelectIndicator:(int)choice;
    -(void)hideAllSelectIndicators;
@end

@implementation SurveyViewController

@synthesize questionCount;
@synthesize selectedAnswerChoice;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // 
    
    // Check question type and hide and show elements on view accordingly
    // Adjust boolean value to test other UI
    [self showAppropriateFields:true];
    
    // for testing, this should be set in the controller that opens this one
    questionCount = 1;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showAppropriateFields:(Boolean)isMultipleChoice
{
    // Question type is multiple choice
    if (isMultipleChoice)
    {
        answerTextField.hidden = true;
        buttonChoice1.hidden = false;
        buttonChoice2.hidden = false;
        buttonChoice3.hidden = false;
        buttonChoice4.hidden = false;
        
    }
    // Question type is short response
    else
    {
        answerTextField.hidden = false;
        buttonChoice1.hidden = true;
        buttonChoice2.hidden = true;
        buttonChoice3.hidden = true;
        buttonChoice4.hidden = true;
    }
}

- (void)showSelectIndicator:(int)choice
{
    [self hideAllSelectIndicators];
    switch (choice) {
        case 1:
            imageChoice1.hidden = false;
            break;
        case 2:
            imageChoice2.hidden = false;
            break;
        case 3:
            imageChoice3.hidden = false;
            break;
        case 4:
            imageChoice4.hidden = false;
            break;
        default:
            break;
    }
}

- (void)hideAllSelectIndicators
{
    imageChoice1.hidden = true;
    imageChoice2.hidden = true;
    imageChoice3.hidden = true;
    imageChoice4.hidden = true;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // Dismisses keyboard
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)nextQuestion:(id)sender
{
    ++questionCount;
}

- (IBAction)previousQuestion:(id)sender
{
    --questionCount;
}

- (IBAction)selectChoice1:(id)sender
{
    [self showSelectIndicator:1];
    selectedAnswerChoice = 1;
}

- (IBAction)selectChoice2:(id)sender
{
    [self showSelectIndicator:2];
    selectedAnswerChoice = 2;
}

- (IBAction)selectChoice3:(id)sender
{
    [self showSelectIndicator:3];
    selectedAnswerChoice = 3;
}

- (IBAction)selectChoice4:(id)sender
{
    [self showSelectIndicator:4];
    selectedAnswerChoice = 4;
}

-(IBAction)backgroundTapped:(id)sender
{
    // Dismisses keyboard
    [self.view endEditing:YES];
}

-(IBAction)submitSurvey:(id)sender
{
    // submit survey
}

@end

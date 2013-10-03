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

@synthesize currentQuestionNumber;
@synthesize totalQuestions;
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
    
    // FOR TESTING, SHOULD CHECK NUMBER OF QUESTIONS
    totalQuestions = 10;
    
    // Initializes variable and gets the first question
    currentQuestionNumber = 0;
    [self getQuestion:currentQuestionNumber];
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

- (void)getQuestion:(int)questionNumber
{
    // FOR TESTING, SHOULD CHECK QUESTION TYPE HERE
    Boolean isMultipleChoice = true;
    
    // Use current question number to set the appropriate fields for the question
    if (isMultipleChoice)
    {
        // SHOULD USE DATA FROM SURVEY TO SET ANSWER CHOICES
        [[buttonChoice1 titleLabel] setText:@"Choice 1"];
        [[buttonChoice2 titleLabel] setText:@"Choice 2"];
        [[buttonChoice3 titleLabel] setText:@"Choice 3"];
        [[buttonChoice4 titleLabel] setText:@"Choice 4"];
    }
    // SHOULD USE DATA FROM SURVEY TO SET QUESTION TEXT
    [currentQuestionText setText:@"Question goes here..."];
    
    // Display the appropriate fields for the question
    [self hideAllSelectIndicators];
    [self showAppropriateFields:isMultipleChoice];
}

- (IBAction)nextQuestion:(id)sender
{
    // SHOULD SAVE ANSWER HERE
    
    // Goes forward one question, loops to first question if at the end
    ++currentQuestionNumber;
    if (currentQuestionNumber == totalQuestions)
    {
        currentQuestionNumber = 0;
    }
    selectedAnswerChoice = 0;
    [self getQuestion:currentQuestionNumber];
}

- (IBAction)previousQuestion:(id)sender
{
    // SHOULD SAVE ANSWER HERE
    
    // Goes back one question, loops to last question if at the beginning
    --currentQuestionNumber;
    if (currentQuestionNumber < 0)
    {
        currentQuestionNumber = totalQuestions - 1;
    }
    selectedAnswerChoice = 0;
    [self getQuestion:currentQuestionNumber];
}

- (IBAction)selectChoice1:(id)sender
{
    // Displays appropriate select indicator and stores answer choice
    [self showSelectIndicator:1];
    selectedAnswerChoice = 1;
}

- (IBAction)selectChoice2:(id)sender
{
    // Displays appropriate select indicator and stores answer choice
    [self showSelectIndicator:2];
    selectedAnswerChoice = 2;
}

- (IBAction)selectChoice3:(id)sender
{
    // Displays appropriate select indicator and stores answer choice
    [self showSelectIndicator:3];
    selectedAnswerChoice = 3;
}

- (IBAction)selectChoice4:(id)sender
{
    // Displays appropriate select indicator and stores answer choice
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
    // SHOULD SEND SURVEY TO DATABASE HERE
}

@end

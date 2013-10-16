//
//  SurveyViewController.m
//  Questionaire_App
//
//  Created by Mohammad Doleh on 9/18/13.
//  Copyright (c) 2013 Tucker Cozzens. All rights reserved.
//

#import "SurveyViewController.h"
#import "AFHTTPRequestOperationManager.h"

#import "Answer.h"
#import "Question.h"
#import "Survey.h"

@interface SurveyViewController ()

@property (strong) Survey *survey;

-(void)showAppropriateFields:(Boolean)isMultipleChoice;
-(void)showSelectIndicator:(int)choice;
-(void)hideAllSelectIndicators;

@end

@implementation SurveyViewController

@synthesize currentQuestionNumber;
@synthesize selectedAnswerChoice;

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
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager GET:@"http://capstone-f13.herokuapp.com/api/v1/Questions/?format=json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSLog(@"%@",responseObject);
            
            self.survey = [Survey surveyWithJSON:responseObject];
            
            // Initializes variable and gets the first question
            currentQuestionNumber = 0;
            [self getQuestion:currentQuestionNumber];

        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            NSLog(@"Error: %@", error);
            
        }];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
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
    Question *question = self.survey.questions[questionNumber];
    
    // Use current question number to set the appropriate fields for the question
    if (question.isMultipleChoice)
    {
     
        
        // TODO: This could be generalized
        // loop through the answers and add a button for each one programmatically
        
        
//        
//        for (Answer *a in question.answers) {
//            
//        }
        
        
        
        [[buttonChoice1 titleLabel] setText:[question.answers[0] text]];
        [[buttonChoice2 titleLabel] setText:[question.answers[1] text]];
        [[buttonChoice3 titleLabel] setText:[question.answers[2] text]];
        [[buttonChoice4 titleLabel] setText:[question.answers[3] text]];
    }

    [currentQuestionText setText:question.text];
    
    // Display the appropriate fields for the question
    [self hideAllSelectIndicators];
    [self showAppropriateFields:question.isMultipleChoice];
}

- (IBAction)nextQuestion:(id)sender
{
    // SHOULD SAVE ANSWER HERE
    
    // Goes forward one question, loops to first question if at the end
    ++currentQuestionNumber;
    if (currentQuestionNumber == [self.survey.questions count])
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
        currentQuestionNumber = [self.survey.questions count] - 1;
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

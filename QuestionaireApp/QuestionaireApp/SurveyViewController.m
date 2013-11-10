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
#import "Constants.h"

@interface SurveyViewController ()

@property (strong) Survey *survey;
@property (strong) AFHTTPRequestOperationManager *manager;

@end

@implementation SurveyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        self.manager = [AFHTTPRequestOperationManager manager];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *authToken = [defaults stringForKey:@"authToken"];
        NSString *patientID = [defaults stringForKey:@"patientID"];
        NSString *questionsURL = [NSString stringWithFormat:@"http://create.cs.kent.edu/questions/%@/%@", authToken, patientID];
        
        [self.manager GET:questionsURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            // NSLog(@"JSON : %@",responseObject);
            
            self.survey = [Survey surveyWithJSON:responseObject];
            
            if (self.survey.questions.count == 0) {
                NSLog(@"Error : no questions in survey");
            }
            else {
                // Initializes variable and gets the first question
                self.currentQuestionNumber = 0;
                [self getQuestion:self.currentQuestionNumber];
            }
            
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

- (void)showAppropriateFieldsForQuestion:(NSUInteger)num
{
    [self hideAllUIElements];
    
    Question *question = self.survey.questions[num];
    
    // Question type is multiple choice
    if (question.isMultipleChoice)
    {
        switch (question.answers.count) {
            case 1: {
                buttonChoice1.hidden = false;
                break;
            }
            case 2: {
                buttonChoice1.hidden = false;
                buttonChoice2.hidden = false;
                break;
            }
            case 3: {
                buttonChoice1.hidden = false;
                buttonChoice2.hidden = false;
                buttonChoice3.hidden = false;
                break;
            }
            case 4: {
                buttonChoice1.hidden = false;
                buttonChoice2.hidden = false;
                buttonChoice3.hidden = false;
                buttonChoice4.hidden = false;
                break;
            }
            default: {
                ratingSlider.hidden = false;
                ratingText.hidden = false;
                ratingNumber.hidden = false;
                break;
            }
        }
    }
    // Question type is short response
    else
    {
        answerTextField.hidden = false;
    }
}

- (void)hideAllUIElements
{
    // Hides everything but the question label, previous, and next buttons
    ratingSlider.hidden = true;
    ratingText.hidden = true;
    ratingNumber.hidden = true;
    buttonChoice1.hidden = true;
    buttonChoice2.hidden = true;
    buttonChoice3.hidden = true;
    buttonChoice4.hidden = true;
    answerTextField.hidden = true;
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
        switch (question.answers.count) {
            case 1: {
                [buttonChoice1 setTitle:[question.answers[0] text] forState:UIControlStateNormal];
                break;
            }
            case 2: {
                [buttonChoice1 setTitle:[question.answers[0] text] forState:UIControlStateNormal];
                [buttonChoice2 setTitle:[question.answers[1] text] forState:UIControlStateNormal];
                break;
            }
            case 3: {
                [buttonChoice1 setTitle:[question.answers[0] text] forState:UIControlStateNormal];
                [buttonChoice2 setTitle:[question.answers[1] text] forState:UIControlStateNormal];
                [buttonChoice3 setTitle:[question.answers[2] text] forState:UIControlStateNormal];
                break;
            }
            case 4: {
                [buttonChoice1 setTitle:[question.answers[0] text] forState:UIControlStateNormal];
                [buttonChoice2 setTitle:[question.answers[1] text] forState:UIControlStateNormal];
                [buttonChoice3 setTitle:[question.answers[2] text] forState:UIControlStateNormal];
                [buttonChoice4 setTitle:[question.answers[3] text] forState:UIControlStateNormal];
                break;
            }
            default: {
                [ratingSlider setMaximumValue:question.answers.count];
                [ratingText setText:[question.answers[(int)[ratingSlider value] - 1] text]];
                [ratingNumber setText:[NSString stringWithFormat:@"%d", (int)[ratingSlider value]]];
            }
        }
    }
    
    [currentQuestionText setText:question.text];
    
    // Display the appropriate fields for the question
    [self hideAllSelectIndicators];
    [self showAppropriateFieldsForQuestion:questionNumber];
}

- (void)getCurrentAnswerText {
    Question *question = self.survey.questions[self.currentQuestionNumber];
    if (!question.isMultipleChoice) {
        question.answerText = answerTextField.text;
    }
}

- (IBAction)nextQuestion:(id)sender
{
    [self getCurrentAnswerText];
    
    // Goes forward one question, loops to first question if at the end
    ++self.currentQuestionNumber;
    if (self.currentQuestionNumber == [self.survey.questions count])
    {
        self.currentQuestionNumber = 0;
    }
    
    [self getQuestion:self.currentQuestionNumber];
}

- (IBAction)previousQuestion:(id)sender
{
    [self getCurrentAnswerText];
    
    // Goes back one question, loops to last question if at the beginning
    --self.currentQuestionNumber;
    if (self.currentQuestionNumber < 0)
    {
        self.currentQuestionNumber = (int)[self.survey.questions count] - 1;
    }
    
    [self getQuestion:self.currentQuestionNumber];
}

- (IBAction)selectChoice1:(id)sender
{
    // Displays appropriate select indicator and stores answer choice
    [self showSelectIndicator:1];
    
    Question *question = self.survey.questions[self.currentQuestionNumber];
    Answer *answer = question.answers[0];
    question.answerText = answer.text;
}

- (IBAction)selectChoice2:(id)sender
{
    // Displays appropriate select indicator and stores answer choice
    [self showSelectIndicator:2];
    
    Question *question = self.survey.questions[self.currentQuestionNumber];
    Answer *answer = question.answers[1];
    question.answerText = answer.text;
}

- (IBAction)selectChoice3:(id)sender
{
    // Displays appropriate select indicator and stores answer choice
    [self showSelectIndicator:3];
    
    Question *question = self.survey.questions[self.currentQuestionNumber];
    Answer *answer = question.answers[2];
    question.answerText = answer.text;
}

- (IBAction)selectChoice4:(id)sender
{
    // Displays appropriate select indicator and stores answer choice
    [self showSelectIndicator:4];
    
    Question *question = self.survey.questions[self.currentQuestionNumber];
    Answer *answer = question.answers[3];
    question.answerText = answer.text;
}

-(IBAction)backgroundTapped:(id)sender
{
    // Dismisses keyboard
    [self.view endEditing:YES];
}

-(IBAction)sliderValueChanged:(id)sender
{
    Question *question = self.survey.questions[self.currentQuestionNumber];
    [ratingText setText:[question.answers[(int)[ratingSlider value] - 1] text]];
    [ratingNumber setText:[NSString stringWithFormat:@"%d", (int)[ratingSlider value]]];
    question.answerText = [question.answers[(int)[ratingSlider value] - 1] text];
}

-(IBAction)submitSurvey:(id)sender
{
    NSMutableArray *response = [[NSMutableArray alloc] initWithCapacity:[self.survey.questions count]];
    
    // NSMutableArray *mutableOperations = [NSMutableArray array];
    
    for (Question *question in self.survey.questions) {
        
        if (!question.answerText) {
            NSLog(@"error: question %lu's answer text was nil",(long)question.questionID);
            
            // TODO: should stop and show a warning in the future
            
            continue;
        }
        
        // NSLog(@"question %lu: %@",(long)question.questionID,question.answerText);
        
        NSDictionary *question_info = @{@"question_id" : [NSString stringWithFormat:@"%lu",(long)question.questionID],
                                        @"answer" : question.answerText
                                        };
        
        [response addObject:question_info];
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *authToken = [defaults stringForKey:@"authToken"];
    NSString *patientID = [defaults stringForKey:@"patientID"];
    
    NSDictionary *parameters = @{@"patient_id" : patientID,
                                 @"access_token": authToken,
                                 @"response" : response};
    
    NSString *URLString = @"http://create.cs.kent.edu/answer/";
    
    NSMutableURLRequest * request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:URLString parameters:parameters];
    AFHTTPRequestOperation *operation = [self.manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"JSON: %@", responseObject);
        
        [self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];
    
    [operation start];
}


@end

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
        [self.manager GET:@"http://capstone-f13.herokuapp.com/api/v1/Questions/?format=json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
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
    Question *question = self.survey.questions[num];
    
    // Question type is multiple choice
    if (question.isMultipleChoice)
    {
        answerTextField.hidden = true;
        
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
        }
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

//        for (Answer *a in question.answers) {
//            
//        }
        
        switch (question.answers.count) {
            case 1: {
                [[buttonChoice1 titleLabel] setText:[question.answers[0] text]];
                break;
            }
            case 2: {
                [[buttonChoice1 titleLabel] setText:[question.answers[0] text]];
                [[buttonChoice2 titleLabel] setText:[question.answers[1] text]];
                break;
            }
            case 3: {
                [[buttonChoice1 titleLabel] setText:[question.answers[0] text]];
                [[buttonChoice2 titleLabel] setText:[question.answers[1] text]];
                [[buttonChoice3 titleLabel] setText:[question.answers[2] text]];
                break;
            }
            case 4: {
                [[buttonChoice1 titleLabel] setText:[question.answers[0] text]];
                [[buttonChoice2 titleLabel] setText:[question.answers[1] text]];
                [[buttonChoice3 titleLabel] setText:[question.answers[2] text]];
                [[buttonChoice4 titleLabel] setText:[question.answers[3] text]];
                break;
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

-(IBAction)submitSurvey:(id)sender
{
    
    NSMutableArray *mutableOperations = [NSMutableArray array];
    
    for (Question *question in self.survey.questions) {
        
        if (!question.answerText) {
            NSLog(@"error: this question's answer text was nil");
            
            // should stop and show a warning in the future
            
            continue;
        }
        
        NSString *URLString = @"http://capstone-f13.herokuapp.com/answer/";
        
        NSDictionary *parameters = @{@"question_id" : [NSString stringWithFormat:@"%lu",question.questionID],
                                     @"patient_id" : @"patient_001",
                                     @"answer" : question.answerText
                                     };
        
        NSMutableURLRequest * request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:URLString parameters:parameters];
        AFHTTPRequestOperation *operation = [self.manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSLog(@"JSON: %@", responseObject);
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            NSLog(@"Error: %@", error);
            
        }];
        
        [mutableOperations addObject:operation];
    }
    
    NSArray *operations = [AFURLConnectionOperation batchOfRequestOperations:mutableOperations progressBlock:^(NSUInteger numberOfFinishedOperations, NSUInteger totalNumberOfOperations) {
        
        NSLog(@"%lu of %lu complete", numberOfFinishedOperations, totalNumberOfOperations);

    } completionBlock:^(NSArray *operations) {
    
        [self.navigationController popViewControllerAnimated:YES];
        
        NSLog(@"All operations in batch complete");

    }];
    
    [[NSOperationQueue mainQueue] addOperations:operations waitUntilFinished:NO];
    
    SURVEY_TAKEN = true;
}

@end

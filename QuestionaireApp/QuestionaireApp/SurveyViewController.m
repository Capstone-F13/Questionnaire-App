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
@property (strong) id storedSurvey;
@property (strong) AFHTTPRequestOperationManager *manager;

@end

@implementation SurveyViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        
        self.navigationItem.hidesBackButton = YES;
        
        self.manager = [AFHTTPRequestOperationManager manager];

        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

        self.storedSurvey = [defaults objectForKey:DEFAULTS_CURRENT_SURVEY];
        
        self.survey = [Survey surveyWithJSON:self.storedSurvey];
    }

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.survey.questions.count == 0) {
        NSLog(@"Error : no questions in survey");
    }
    else {
        // Initializes variable and gets the first question
        self.totalScore = 0;
        self.currentQuestionNumber = 0;
        [self getQuestion:self.currentQuestionNumber];
    }
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
    
    int answerNumber = -1;
    if (question.answerText) {
        for (int i=0; i<question.answers.count; i++) {
            if ([[question.answers[i] text] isEqualToString:question.answerText]) {
                answerNumber = i;
                break;
            }
        }
    }
    
    BOOL moreThan4 = NO;
    
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
                moreThan4 = YES;
                [ratingSlider setMaximumValue:question.answers.count];

                if (answerNumber == -1) {
                    ratingSlider.value = 1;
                    [ratingText setText:[question.answers[0] text]];
                    [ratingNumber setText:@"1"];
                }
                else {
                    ratingSlider.value = answerNumber + 1;
                    [ratingText setText:question.answerText];
                    [ratingNumber setText:[NSString stringWithFormat:@"%d",answerNumber+1]];
                }
            }
        }
    }
    else {
        moreThan4 = YES;
        if (question.answerText) {
            answerTextField.text = question.answerText;
        }
        else {
            answerTextField.text = @"Type your answer here";
        }
    }
    
    if (!moreThan4 && answerNumber != -1) {
        NSLog(@"show %d",answerNumber+1);
        [self showSelectIndicator:answerNumber+1];
    }
    
    [currentQuestionText setText:question.text];
    
    // Display the appropriate fields for the question
    [self hideAllSelectIndicators];
    [self showAppropriateFieldsForQuestion:questionNumber];
    
    if (!question.answerText) {
        nextButton.hidden = YES;
    }
    else {
        nextButton.hidden = NO;
    }
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

    BOOL ascendingPositivity = [self.survey.questions[self.currentQuestionNumber] isAscendingPositivity];
    
    int score = 0;
    if (!ascendingPositivity) {
        score = (int)ratingSlider.value;
    }
    else {
        score = (int)ratingSlider.maximumValue - (int)ratingSlider.value + 1;
    }
    
    if (self.currentQuestionNumber > 0) {
        self.totalScore += score;
        self.possibleScore += ratingSlider.maximumValue;
    }
    
    ++self.currentQuestionNumber;

    if (self.currentQuestionNumber == [self.survey.questions count]) {
        
        [self hideAllUIElements];
        
        nextButton.hidden = YES;
        
        self.playButton.hidden = NO;
        
        int finalValue = self.totalScore / (int)(self.survey.questions.count - 1);
        
        if (finalValue > 4) {
            currentQuestionText.text = @"You seem to be thinking negatively.";
            answerTextField.hidden = NO;
            answerTextField.text = @"Let's use your theme song to push out the negative thoughts and replace them with positive thoughts.";
        }
        else {
            currentQuestionText.text = @"Keep up the positive thinking! :)";
            self.dontPlayButton.hidden = NO;
        }
    }
    else {
        [self getQuestion:self.currentQuestionNumber];
    }
}

- (IBAction)selectChoice1:(id)sender
{
    // Displays appropriate select indicator and stores answer choice
    [self showSelectIndicator:1];
    
    Question *question = self.survey.questions[self.currentQuestionNumber];
    Answer *answer = question.answers[0];
    question.answerText = answer.text;
    
    nextButton.hidden = NO;
}

- (IBAction)selectChoice2:(id)sender
{
    // Displays appropriate select indicator and stores answer choice
    [self showSelectIndicator:2];
    
    Question *question = self.survey.questions[self.currentQuestionNumber];
    Answer *answer = question.answers[1];
    question.answerText = answer.text;
    
    nextButton.hidden = NO;
}

- (IBAction)selectChoice3:(id)sender
{
    // Displays appropriate select indicator and stores answer choice
    [self showSelectIndicator:3];
    
    Question *question = self.survey.questions[self.currentQuestionNumber];
    Answer *answer = question.answers[2];
    question.answerText = answer.text;
    
    nextButton.hidden = NO;
}

- (IBAction)selectChoice4:(id)sender
{
    // Displays appropriate select indicator and stores answer choice
    [self showSelectIndicator:4];
    
    Question *question = self.survey.questions[self.currentQuestionNumber];
    Answer *answer = question.answers[3];
    question.answerText = answer.text;
    
    nextButton.hidden = NO;
}

-(IBAction)backgroundTapped:(id)sender
{
    if (!answerTextField.hidden) {
        // Dismisses keyboard
        [self.view endEditing:YES];
        nextButton.hidden = NO;
    }
}

-(IBAction)sliderValueChanged:(id)sender
{
    Question *question = self.survey.questions[self.currentQuestionNumber];
    [ratingText setText:[question.answers[(int)[ratingSlider value] - 1] text]];
    [ratingNumber setText:[NSString stringWithFormat:@"%d", (int)[ratingSlider value]]];
    question.answerText = [question.answers[(int)[ratingSlider value] - 1] text];
    
    nextButton.hidden = NO;
}

- (void)submitSurvey
{
    NSMutableArray *response = [[NSMutableArray alloc] initWithCapacity:[self.survey.questions count]];
    
    for (Question *question in self.survey.questions) {
        
        NSDictionary *question_info = @{@"question_id" : [NSString stringWithFormat:@"%lu",(long)question.questionID],
                                        @"answer" : question.answerText
                                        };
        
        [response addObject:question_info];
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *authToken = [defaults stringForKey:DEFAULTS_AUTH_TOKEN];
    NSString *patientID = [defaults stringForKey:DEFAULTS_PATIENT_ID];
    
    NSLocale *currentLocale = [NSLocale currentLocale];
    NSString *timeStamp = [[NSDate date] descriptionWithLocale:currentLocale];
    
    NSString *didListenString = nil;
    
    if (self.totalScore / self.survey.questions.count > 4) {
        didListenString = @"Retook survey.";
    }
    else if (self.playedSong) {
        didListenString = @"Played song.";
    }
    else {
        didListenString = @"Did not play song.";
    }
    
    NSDictionary *parameters = @{@"patient_id": patientID,
                                 @"access_token": authToken,
                                 @"response": response,
                                 @"timestamp": timeStamp,
                                 @"score": [NSString stringWithFormat:@"%d/%d",self.totalScore,self.possibleScore],
                                 @"did_listen": didListenString
                                 };
    
    __block BOOL checkedStatus = NO;
    
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (!checkedStatus) {
            checkedStatus = YES;
            switch (status) {
                case AFNetworkReachabilityStatusReachableViaWWAN:
                case AFNetworkReachabilityStatusReachableViaWiFi: {
                    
                    NSLog(@"reachable --> survey view controller");
                    
                    // NSLog(@"%@",parameters);
                    
                    NSString *URLString = [NSString stringWithFormat: @"%@/answer/", SERVER_ADDRESS];
                    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:URLString parameters:parameters];
                    
                    AFHTTPRequestOperation *operation = [self.manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
                        
                        //        NSLog(@"JSON: %@", responseObject);
                        
                        [self finishUp];
                        
                    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                        
                        NSLog(@"Error: %@", error);
                        
                        [self.navigationController popViewControllerAnimated:YES];
                        
                    }];
                    
                    [operation start];
                    
                    break;
                }

                case AFNetworkReachabilityStatusNotReachable:
                default: {

                    NSLog(@"not reachable --> survey view controller");
                    
                    NSArray *parametersArray = [defaults arrayForKey:DEFAULTS_PARAMETERS_ARRAY];
                    NSMutableArray *mutableParametersArray = nil;

                    if (parametersArray) {
                        mutableParametersArray = [parametersArray mutableCopy];
                    }
                    else {
                        mutableParametersArray = [NSMutableArray new];
                    }
                    
                    [mutableParametersArray addObject:parameters];
                    [defaults setObject:mutableParametersArray forKey:DEFAULTS_PARAMETERS_ARRAY];
                    
                    [self finishUp];
                    
                    break;
                }
            }
        }
    }];
    
    [manager startMonitoring];
}


- (void)finishUp {
    if (self.totalScore / self.survey.questions.count > 4) {
        
        self.playButton.hidden = YES;
        
        self.survey = [Survey surveyWithJSON:self.storedSurvey];
        self.totalScore = 0;
        
        self.currentQuestionNumber = 0;
        [self getQuestion:self.currentQuestionNumber];
    }
    else {
        double currentTime = [[[NSDate alloc] init] timeIntervalSince1970];
        [[NSUserDefaults standardUserDefaults] setDouble:currentTime forKey:DEFAULTS_TIME_SURVEY_SENT];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)playSong:(id)sender {

    NSString *recordedAudioPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)
                                   objectAtIndex:0];
    
    recordedAudioPath = [recordedAudioPath stringByAppendingPathComponent:@"recorded.caf"];
    NSURL *recordURL = [NSURL fileURLWithPath:recordedAudioPath];
    
    NSError *error;
    
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:recordURL error:&error];
    if (!self.audioPlayer) {
        NSLog(@"%@",error);
        self.playedSong = YES;
        
        [self submitSurvey];
    }
    else {
        [self.audioPlayer setDelegate:self];
        [self.audioPlayer prepareToPlay];
        
        self.audioPlayer.numberOfLoops = 0;
        
        [self.audioPlayer play];
    }
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    self.playedSong = YES;
    
    [self submitSurvey];
}

- (IBAction)dontPlaySong:(id)sender {

    self.playedSong = NO;
    
    [self submitSurvey];
}

@end

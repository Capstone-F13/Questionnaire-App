//
//  SurveyViewController.h
//  Questionaire_App
//
//  Created by Mohammad Doleh on 9/18/13.
//  Copyright (c) 2013 Tucker Cozzens. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SurveyViewController : UIViewController
{

    IBOutlet UILabel *currentQuestionText;
    IBOutlet UITextView *answerTextField;
    IBOutlet UIImageView *imageChoice1;
    IBOutlet UIImageView *imageChoice2;
    IBOutlet UIImageView *imageChoice3;
    IBOutlet UIImageView *imageChoice4;
    IBOutlet UIButton *buttonChoice1;
    IBOutlet UIButton *buttonChoice2;
    IBOutlet UIButton *buttonChoice3;
    IBOutlet UIButton *buttonChoice4;
}
-(IBAction)backgroundTapped:(id)sender;
-(IBAction)nextQuestion:(id)sender;
-(IBAction)previousQuestion:(id)sender;
-(IBAction)selectChoice1:(id)sender;
-(IBAction)selectChoice2:(id)sender;
-(IBAction)selectChoice3:(id)sender;
-(IBAction)selectChoice4:(id)sender;
-(IBAction)submitSurvey:(id)sender;

@property (nonatomic) int currentQuestionNumber;
@property (nonatomic) int totalQuestions;
@property (nonatomic) int selectedAnswerChoice;
@end

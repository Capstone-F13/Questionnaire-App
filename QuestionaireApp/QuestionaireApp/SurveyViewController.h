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
    // Pointer to label containing question text
    IBOutlet UILabel *currentQuestionText;
    // Pointer to textView containing text response
    IBOutlet UITextView *answerTextField;
    
    // Pointers to checkmark images for multiple choice
    IBOutlet UIImageView *imageChoice1;
    IBOutlet UIImageView *imageChoice2;
    IBOutlet UIImageView *imageChoice3;
    IBOutlet UIImageView *imageChoice4;
    
    // Pointers to buttons for multiple choice
    IBOutlet UIButton *buttonChoice1;
    IBOutlet UIButton *buttonChoice2;
    IBOutlet UIButton *buttonChoice3;
    IBOutlet UIButton *buttonChoice4;
}
// Makes the keyboard go away
-(IBAction)backgroundTapped:(id)sender;

// Moves on to the next question
-(IBAction)nextQuestion:(id)sender;
// Moves back a question
-(IBAction)previousQuestion:(id)sender;

// Handles  pushing of multiple choice buttons
-(IBAction)selectChoice1:(id)sender;
-(IBAction)selectChoice2:(id)sender;
-(IBAction)selectChoice3:(id)sender;
-(IBAction)selectChoice4:(id)sender;

// Sends off the survey responses
-(IBAction)submitSurvey:(id)sender;

// Holds current question number (starts at 0)
@property (nonatomic) int currentQuestionNumber;

@end

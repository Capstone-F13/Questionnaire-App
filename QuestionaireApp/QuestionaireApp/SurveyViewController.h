//
//  SurveyViewController.h
//  Questionaire_App
//
//  Created by Mohammad Doleh on 9/18/13.
//  Copyright (c) 2013 Tucker Cozzens. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface SurveyViewController : UIViewController<AVAudioPlayerDelegate>
{
    // Pointer to label containing question text
    IBOutlet UILabel *currentQuestionText;
    // Pointer to textView containing text response
    IBOutlet UITextView *answerTextField;

    IBOutlet UIButton *nextButton;
    
    NSMutableArray *toolbarButtons;
    
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
    
    // Pointers to objects for rating questions
    IBOutlet UISlider *ratingSlider;
    IBOutlet UILabel *ratingText;
    IBOutlet UILabel *ratingNumber;
}

@property (strong, nonatomic) IBOutlet UIButton *playButton;
@property (strong, nonatomic) IBOutlet UIButton *dontPlayButton;
- (IBAction)playSong:(id)sender;
- (IBAction)dontPlaySong:(id)sender;

@property(nonatomic, retain) AVAudioPlayer *audioPlayer;

// Makes the keyboard go away
-(IBAction)backgroundTapped:(id)sender;

// Moves on to the next question
-(IBAction)nextQuestion:(id)sender;

// Handles  pushing of multiple choice buttons
-(IBAction)selectChoice1:(id)sender;
-(IBAction)selectChoice2:(id)sender;
-(IBAction)selectChoice3:(id)sender;
-(IBAction)selectChoice4:(id)sender;

-(IBAction)sliderValueChanged:(id)sender;

// Holds current question number (starts at 0)
@property (nonatomic) int currentQuestionNumber;

@property (nonatomic) int totalScore;
@property (nonatomic) int possibleScore;

@property (nonatomic) BOOL playedSong;

@end

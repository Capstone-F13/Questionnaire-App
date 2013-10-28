//
//  SingALongMenuViewController.m
//  QuestionaireApp
//
//  Created by Mohammad Doleh on 10/14/13.
//  Copyright (c) 2013 Tucker Cozzens. All rights reserved.
//

#import "SingALongMenuViewController.h"
#import "Constants.h"

@interface SingALongMenuViewController ()

@end

@implementation SingALongMenuViewController

// Boolean to toggle play/pause
bool SingALongMenuIsPlaying = false;

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
	
    if (SURVEY_TAKEN)
    {
        playPause.hidden = false;
        stopButton.hidden = false;
        playRecordingLabel.hidden = false;
    }
    else
    {
        playPause.hidden = true;
        stopButton.hidden = true;
        playRecordingLabel.hidden = true;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)playPausePlayback:(id)sender
{
    UIImage *icon;
    if (SingALongMenuIsPlaying)
    {
        // Set button image to play icon
        icon = [UIImage imageNamed:PLAY_ICON];
        SingALongMenuIsPlaying = false;
        
        // SHOULD PLAY PRE-RECORDED SONG HERE
        //
    }
    else
    {
        // Set button image to pause icon
        icon = [UIImage imageNamed:PAUSE_ICON];
        SingALongMenuIsPlaying = true;
        
        // SHOULD PAUSE SONG HERE
        //
    }
    [playPause setImage:icon forState:UIControlStateNormal];
}

-(IBAction)stopPlayback:(id)sender
{
    // SHOULD STOP PLAYBACK HERE
    //
}

@end

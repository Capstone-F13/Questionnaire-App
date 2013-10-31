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

bool singMenuRepositioned = false;
CGRect playStopButtonsContainerPortraitPosition;
CGRect playStopButtonsContainerLandscapePosition;

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
    
    // Register for device rotation notifications
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter]
    addObserver:self selector:@selector(orientationChanged:)
    name:UIDeviceOrientationDidChangeNotification
    object:[UIDevice currentDevice]];
    
    playStopButtonsContainerPortraitPosition = CGRectMake(80, 270, 160, 92);
    
    // Adjust play and stop buttons as necessary
    UIDevice *device = [UIDevice currentDevice];
    if (device.orientation == UIDeviceOrientationLandscapeLeft || device.orientation == UIDeviceOrientationLandscapeRight)
    {
        playStopButtonsContainer.frame = CGRectOffset(playStopButtonsContainer.frame, 0, 75);
    }
    else if (device.orientation == UIDeviceOrientationPortrait)
    {
        playStopButtonsContainer.frame = playStopButtonsContainerPortraitPosition;
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

- (void) orientationChanged:(NSNotification *)note
{
    UIDevice * device = note.object;
    // Adjusts play and stop buttons as necessary
    switch(device.orientation)
    {
        case UIDeviceOrientationPortrait:
            playStopButtonsContainer.frame = playStopButtonsContainerPortraitPosition;
            singMenuRepositioned = false;
            break;
        case UIDeviceOrientationLandscapeLeft:
            if (!singMenuRepositioned)
            {
                playStopButtonsContainer.frame = CGRectOffset(playStopButtonsContainer.frame, 0, 40);
                singMenuRepositioned = true;
            }
            break;
        case UIDeviceOrientationLandscapeRight:
            if (!singMenuRepositioned)
            {
                playStopButtonsContainer.frame = CGRectOffset(playStopButtonsContainer.frame, 0, 40);
                singMenuRepositioned = true;
            }
            break;
            
        default:
            break;
    };
}

@end

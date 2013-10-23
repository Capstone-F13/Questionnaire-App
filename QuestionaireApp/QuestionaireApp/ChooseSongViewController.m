//
//  ChooseSongViewController.m
//  QuestionaireApp
//
//  Created by Mohammad Doleh on 10/14/13.
//  Copyright (c) 2013 Tucker Cozzens. All rights reserved.
//

#import "ChooseSongViewController.h"
#import "Constants.h"

@interface ChooseSongViewController ()

@end

@implementation ChooseSongViewController

bool chooseMenuIsPlaying = false;

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)cancelRecordNew:(id)sender
{
    // Dismiss the view and return the Sing-a-long menu
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(IBAction)playPausePlayback:(id)sender
{
    UIImage *icon;
    if (chooseMenuIsPlaying)
    {
        // Set button image to play icon
        icon = [UIImage imageNamed:PLAY_ICON];
        chooseMenuIsPlaying = false;
        
        // SHOULD PLAY CHOSEN SONG HERE
        //
    }
    else
    {
        // Set button image to pause icon
        icon = [UIImage imageNamed:PAUSE_ICON];
        chooseMenuIsPlaying = true;
        
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

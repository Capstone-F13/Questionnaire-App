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

@synthesize musicPlayer;

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
	
    musicPlayer = [MPMusicPlayerController iPodMusicPlayer];
    //[volumeSlider setValue:[musicPlayer volume]];
    [self registerMediaPlayerNotifications];
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
    if ([musicPlayer playbackState] == MPMusicPlaybackStatePaused)
    {
        // Set button image to play icon
        icon = [UIImage imageNamed:PLAY_ICON];
        
        [musicPlayer play];
    }
    else
    {
        // Set button image to pause icon
        icon = [UIImage imageNamed:PAUSE_ICON];
        
        [musicPlayer pause];
    }
    [playPause setImage:icon forState:UIControlStateNormal];
}

-(IBAction)stopPlayback:(id)sender
{
    [musicPlayer stop];
}

-(IBAction)volumeChanged:(id)sender
{
    
}

-(IBAction)showMediaPicker:(id)sender
{
    MPMediaPickerController *mediaPicker = [[MPMediaPickerController alloc] initWithMediaTypes: MPMediaTypeMusic];
    mediaPicker.delegate = self;
    mediaPicker.allowsPickingMultipleItems = NO;
    mediaPicker.prompt = NSLocalizedString(@"Select Your Favorite Song!", nil);
    [mediaPicker loadView];
    [[self navigationController] presentViewController:mediaPicker animated:YES completion:nil];
}

-(void)registerMediaPlayerNotifications
{
    
}

@end

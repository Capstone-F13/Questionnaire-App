//
//  SingALongMenuViewController.m
//  QuestionaireApp
//
//  Created by Mohammad Doleh on 10/14/13.
//  Copyright (c) 2013 Tucker Cozzens. All rights reserved.
//

#import "SingALongMenuViewController.h"

@interface SingALongMenuViewController ()

@end

@implementation SingALongMenuViewController
@synthesize audioPlayer;

bool RecordMenuIsPlaying2 = false;

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
    
    // Init audio with playback capability
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    NSString *recordedAudioPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)
                                   objectAtIndex:0];
    
    recordedAudioPath = [recordedAudioPath stringByAppendingPathComponent:@"recorded.caf"];
    NSURL *recordURL = [NSURL fileURLWithPath:recordedAudioPath];
    NSError *error;
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:recordURL error:&error];
    audioPlayer.numberOfLoops = 0;
    
    [audioPlayer setDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)playPausePlayback:(id)sender
{
    UIImage *icon;
    if (RecordMenuIsPlaying2)
    {
        // Set button image to play icon
        icon = [UIImage imageNamed:PLAY_ICON];
        RecordMenuIsPlaying2 = false;
        
        [self pauseRecording];
    }
    else
    {
        // Set button image to pause icon
        icon = [UIImage imageNamed:PAUSE_ICON];
        RecordMenuIsPlaying2 = true;
        
        [self playRecording];
    }
    [playPause setImage:icon forState:UIControlStateNormal];
}

-(void)playRecording{
    NSLog(@"playRecording");
    [audioPlayer play];
    NSLog(@"playing");
}

-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    NSLog(@"Finished PLaying");
    [self playPausePlayback:self];
    
}

-(void)pauseRecording{
    NSLog(@"pauseRecording");
    [audioPlayer pause];
    NSLog(@"pausing");
}

-(IBAction)stopPlayback:(id)sender
{

    NSLog(@"stopPlaying");
    [audioPlayer stop];
    [self playPausePlayback:self];
    NSLog(@"stopped");
}

@end

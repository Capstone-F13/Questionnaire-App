//
//  RecordViewController.m
//  QuestionaireApp
//
//  Created by Mohammad Doleh on 10/14/13.
//  Copyright (c) 2013 Tucker Cozzens. All rights reserved.
//

#import "RecordViewController.h"

@interface RecordViewController ()

@end

@implementation RecordViewController
@synthesize audioPlayer;

bool RecordMenuIsPlaying = false;
bool RecordMenuIsRecording = false;
bool recordMenuRepositioned = false;
CGRect playStopButtonsContainerPortraitPosition;

- (void)checkIfFileExists
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:[NSString stringWithFormat:@"%@/recordTest.caf", [[NSBundle mainBundle] resourcePath]]]) {
        playPause.hidden = true;
        stop.hidden = true;
    }
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    NSLog(@"Here");
    UIImage *icon;
    icon = [UIImage imageNamed:PLAY_ICON];
    [playPause setImage:icon forState:UIControlStateNormal];
}

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
    [self checkIfFileExists];
    self.audioPlayer.delegate = self;
    
    // Register for device rotation notifications
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(orientationChanged:)
     name:UIDeviceOrientationDidChangeNotification
     object:[UIDevice currentDevice]];
    
    [self savePortraitViewPositions];
    
    // Adjust play and stop buttons as necessary
    UIDevice *device = [UIDevice currentDevice];
    if (device.orientation == UIDeviceOrientationLandscapeLeft || device.orientation == UIDeviceOrientationLandscapeRight)
    {
        playStopButtonsContainer.frame = CGRectOffset(playStopButtonsContainer.frame, 0, 90);
        recordMenuRepositioned = true;
    }
    else if (device.orientation == UIDeviceOrientationPortrait)
    {
        [self setPortraitViewPositions];
    }
}

- (void) orientationChanged:(NSNotification *)note
{
    UIDevice * device = note.object;
    // Adjusts play and stop buttons as necessary
    switch(device.orientation)
    {
        case UIDeviceOrientationPortrait:
            [self setPortraitViewPositions];
            break;
        case UIDeviceOrientationLandscapeLeft:
            [self setLandscapeViewPositions];
            break;
        case UIDeviceOrientationLandscapeRight:
            [self setLandscapeViewPositions];
            break;
            
        default:
            break;
    };
}

- (void)savePortraitViewPositions
{
    playStopButtonsContainerPortraitPosition = CGRectMake(80, 290, 160, 108);
}

- (void)setPortraitViewPositions
{
    playStopButtonsContainer.frame = playStopButtonsContainerPortraitPosition;
    recordMenuRepositioned = false;
}

- (void)setLandscapeViewPositions
{
    if (!recordMenuRepositioned)
    {
        playStopButtonsContainer.frame = CGRectOffset(playStopButtonsContainer.frame, 0, 50);
        recordMenuRepositioned = true;
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
    if (RecordMenuIsPlaying)
    {
        // Set button image to play icon
        icon = [UIImage imageNamed:PLAY_ICON];
        RecordMenuIsPlaying = false;
        
        // SHOULD PLAY PRE-RECORDED SONG HERE
        //
        
    }
    else
    {
        // Set button image to pause icon
        icon = [UIImage imageNamed:PAUSE_ICON];
        RecordMenuIsPlaying = true;
        
        [self playRecording];
        // SHOULD PAUSE SONG HERE
        //
    }
    [playPause setImage:icon forState:UIControlStateNormal];
}

-(void)playRecording{
    NSLog(@"playRecording");
    // Init audio with playback capability
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/recordTest.caf", [[NSBundle mainBundle] resourcePath]]];
    NSError *error;
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    audioPlayer.numberOfLoops = 0;
    [audioPlayer play];
    NSLog(@"playing");
}

-(IBAction)startStopRecording:(id)sender
{
    UIImage *icon;
    if (RecordMenuIsRecording)
    {
        // Set button image to start recording icon
        icon = [UIImage imageNamed:RECORD_ICON];
        RecordMenuIsRecording = false;
        
        [self stopRecording];
        [self checkIfFileExists];
    }
    else
    {
        // Set button image to stop recording icon
        icon = [UIImage imageNamed:CURRENTLY_RECORDING_ICON];
        RecordMenuIsRecording = true;
        
        [self startRecording];
    }
    [record setImage:icon forState:UIControlStateNormal];
}

-(void)stopRecording
{
    NSLog(@"stopRecording");
    [audioRecorder stop];
    NSLog(@"stopped");
}

-(void)startRecording
{
    NSLog(@"startRecording");
    audioRecorder = nil;
    
    // Init audio with record capability
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryRecord error:nil];
    
    NSMutableDictionary *recordSettings = [[NSMutableDictionary alloc] initWithCapacity:10];
    [recordSettings setObject:[NSNumber numberWithInt: kAudioFormatLinearPCM] forKey: AVFormatIDKey];
    [recordSettings setObject:[NSNumber numberWithFloat:44100.0] forKey: AVSampleRateKey];
    [recordSettings setObject:[NSNumber numberWithInt:2] forKey:AVNumberOfChannelsKey];
    [recordSettings setObject:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
    [recordSettings setObject:[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsBigEndianKey];
    [recordSettings setObject:[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsFloatKey];

    
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/recordTest.caf", [[NSBundle mainBundle] resourcePath]]];
    
    
    NSError *error = nil;
    audioRecorder = [[ AVAudioRecorder alloc] initWithURL:url settings:recordSettings error:&error];
    
    if ([audioRecorder prepareToRecord] == YES){
        [audioRecorder record];
    }else {
        int errorCode = CFSwapInt32HostToBig ([error code]); 
        NSLog(@"Error: %@ [%4.4s])" , [error localizedDescription], (char*)&errorCode); 
        
    }
    NSLog(@"recording");
}

-(IBAction)stopPlayback:(id)sender
{
    // SHOULD STOP PLAYBACK HERE
    //
    NSLog(@"stopPlaying");
    [audioPlayer stop];
    NSLog(@"stopped");
}

-(IBAction)finishRecordNew:(id)sender
{
    // SHOULD SAVE RECORDING HERE
    //
    
    // Dismiss the view and return the Sing-a-long menu
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end

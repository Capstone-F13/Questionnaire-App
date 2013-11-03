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
@synthesize audioPlayer, musicPlayer,session, currentSelection;

bool RecordMenuIsPlaying = false;
bool RecordMenuIsRecording = false;
bool recordMenuRepositioned = false;
CGRect playStopButtonsContainerPortraitPosition;

- (void)checkIfFileExists
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:[NSString stringWithFormat:@"recorded.caf"]]) {
        playPause.hidden = true;
        stop.hidden = true;
    }
}

-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    NSLog(@"Finished PLaying");
    [self playPausePlayback:self];
    
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
    //[self checkIfFileExists];
    
    if (self.session == nil){
		self.session = [AVAudioSession sharedInstance];
		NSLog(@"Creating New Session");
    }
	NSError *error;
	[self.session setCategory:AVAudioSessionCategoryPlayAndRecord error:&error];
	[self.session setActive:YES error:nil];
    
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
    [self setPlayBackAudioPlayer];
    UIImage *icon;
    if (RecordMenuIsPlaying)
    {
        // Set button image to play icon
        icon = [UIImage imageNamed:PLAY_ICON];
        RecordMenuIsPlaying = false;
        
        [self pauseRecording];
    }
    else
    {
        // Set button image to pause icon
        icon = [UIImage imageNamed:PAUSE_ICON];
        RecordMenuIsPlaying = true;
        
        [self playRecording];
    }
    [playPause setImage:icon forState:UIControlStateNormal];
}

-(void)playRecording{
    NSLog(@"playRecording");
    [audioPlayer play];
    NSLog(@"playing");
}

-(void)pauseRecording{
    NSLog(@"pauseRecording");
    [audioPlayer pause];
    NSLog(@"pausing");
}

-(IBAction)startStopRecording:(id)sender
{
    [self setRecordAudioPlayer];
    UIImage *icon;
    if (RecordMenuIsRecording)
    {
        // Set button image to start recording icon
        icon = [UIImage imageNamed:RECORD_ICON];
        RecordMenuIsRecording = false;
        
        [self stopRecording];
        //[self checkIfFileExists];
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
    [audioPlayer stop];
    NSLog(@"stopped");
}

-(void)startRecording
{
    NSLog(@"startRecording");
    audioRecorder = nil;
    
    // Init audio with record capability
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    
    NSMutableDictionary *recordSettings = [[NSMutableDictionary alloc] initWithCapacity:10];
    [recordSettings setObject:[NSNumber numberWithInt: kAudioFormatLinearPCM] forKey: AVFormatIDKey];
    [recordSettings setObject:[NSNumber numberWithFloat:44100.0] forKey: AVSampleRateKey];
    [recordSettings setObject:[NSNumber numberWithInt:2] forKey:AVNumberOfChannelsKey];
    [recordSettings setObject:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
    [recordSettings setObject:[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsBigEndianKey];
    [recordSettings setObject:[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsFloatKey];

    
    NSString *recordedAudioPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)
                                   objectAtIndex:0];
    
    recordedAudioPath = [recordedAudioPath stringByAppendingPathComponent:@"recorded.caf"];
    NSURL *recordURL = [NSURL fileURLWithPath:recordedAudioPath];

    NSError *error = nil;
    audioRecorder = [[ AVAudioRecorder alloc] initWithURL:recordURL settings:recordSettings error:&error];
    
    if ([audioRecorder prepareToRecord] == YES){
        [audioPlayer play];
        [audioRecorder record];
    }else {
        int errorCode = CFSwapInt32HostToBig ([error code]); 
        NSLog(@"Error: %@ [%4.4s])" , [error localizedDescription], (char*)&errorCode); 
        
    }
    NSLog(@"recording");
}

-(IBAction)stopPlayback:(id)sender
{
    [self setPlayBackAudioPlayer];
    NSLog(@"stopPlaying");
    [audioPlayer stop];
    [self playPausePlayback:self];
    NSLog(@"stopped");
}

-(IBAction)finishRecordNew:(id)sender
{
    // Dismiss the view and return the Sing-a-long menu
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void)setRecordAudioPlayer
{
    NSError *error;
    musicPlayer = [MPMusicPlayerController iPodMusicPlayer];
    
    //[musicPlayer play];
    
    MPMediaItem *currentItem = [musicPlayer nowPlayingItem];
    if (currentItem == nil){
        errorLabel.text = @"You must select a music \n to play with the recording";
        errorLabel.hidden = NO;
        return;
    }
    
    self.currentSelection=[currentItem valueForProperty:MPMediaItemPropertyAssetURL];
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:self.currentSelection error:&error];
    NSLog(@"url=%@",self.currentSelection);
    [audioPlayer setDelegate:self];
}

-(void)setPlayBackAudioPlayer
{
    // Init audio with playback capability
    NSError *error;
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    NSString *recordedAudioPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)
                                   objectAtIndex:0];
    
    recordedAudioPath = [recordedAudioPath stringByAppendingPathComponent:@"recorded.caf"];
    NSURL *recordURL = [NSURL fileURLWithPath:recordedAudioPath];
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:recordURL error:&error];
    audioPlayer.numberOfLoops = 0;
    [audioPlayer setDelegate:self];
}


@end

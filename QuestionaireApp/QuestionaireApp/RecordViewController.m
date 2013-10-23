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

bool RecordMenuIsPlaying = false;
bool RecordMenuIsRecording = false;

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
        
        // SHOULD PAUSE SONG HERE
        //
    }
    [playPause setImage:icon forState:UIControlStateNormal];
}

-(IBAction)startStopRecording:(id)sender
{
    UIImage *icon;
    if (RecordMenuIsRecording)
    {
        // Set button image to start recording icon
        icon = [UIImage imageNamed:RECORD_ICON];
        RecordMenuIsRecording = false;
        
        [self startRecording];
    }
    else
    {
        // Set button image to stop recording icon
        icon = [UIImage imageNamed:CURRENTLY_RECORDING_ICON];
        RecordMenuIsRecording = true;
        
        // SHOULD STOP RECORDING SONG HERE
        //
    }
    [record setImage:icon forState:UIControlStateNormal];
}

-(void)startRecording
{
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
}

-(IBAction)finishRecordNew:(id)sender
{
    // SHOULD SAVE RECORDING HERE
    //
    
    // Dismiss the view and return the Sing-a-long menu
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end

//
//  RecordViewController.h
//  QuestionaireApp
//
//  Created by Mohammad Doleh on 10/14/13.
//  Copyright (c) 2013 Tucker Cozzens. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "Constants.h"

AVAudioRecorder *audioRecorder;
int recordEncoding;

@interface RecordViewController : UIViewController <AVAudioPlayerDelegate, MPMediaPickerControllerDelegate>
{
    IBOutlet UIButton *playPause;
    IBOutlet UIButton *record;
    IBOutlet UIButton *stop;
    IBOutlet UIView *playStopButtonsContainer;
    IBOutlet UILabel *errorLabel;
    
}
@property (nonatomic, retain) MPMusicPlayerController *musicPlayer;
@property(nonatomic, retain) AVAudioPlayer *audioPlayer;
@property (nonatomic, retain)  AVAudioSession *session;
@property (nonatomic, retain) NSURL *currentSelection;
-(IBAction)playPausePlayback:(id)sender;
-(IBAction)stopPlayback:(id)sender;
-(IBAction)startStopRecording:(id)sender;
-(IBAction)finishRecordNew:(id)sender;
-(void)startRecording;

@end

//
//  RecordViewController.h
//  QuestionaireApp
//
//  Created by Mohammad Doleh on 10/14/13.
//  Copyright (c) 2013 Tucker Cozzens. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "Constants.h"

AVAudioRecorder *audioRecorder;
int recordEncoding;

@interface RecordViewController : UIViewController <AVAudioPlayerDelegate>
{
    IBOutlet UIButton *playPause;
    IBOutlet UIButton *record;
    IBOutlet UIButton *stop;
}
@property(nonatomic, retain) AVAudioPlayer *audioPlayer;
-(IBAction)playPausePlayback:(id)sender;
-(IBAction)stopPlayback:(id)sender;
-(IBAction)startStopRecording:(id)sender;
-(IBAction)finishRecordNew:(id)sender;
-(void)startRecording;

@end

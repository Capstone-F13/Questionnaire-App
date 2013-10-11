//
//  RecordSongViewController.h
//  QuestionaireApp
//
//  Created by Andrew Kelley on 10/10/13.
//  Copyright (c) 2013 Tucker Cozzens. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

AVAudioPlayer *audioPlayer;
AVAudioRecorder *audioRecorder;
int recordEncoding;

@interface RecordSongViewController : UIViewController

- (IBAction) startRecording;
- (IBAction) stopRecording;
- (IBAction) playRecording;
- (IBAction) stopPlaying;

@end

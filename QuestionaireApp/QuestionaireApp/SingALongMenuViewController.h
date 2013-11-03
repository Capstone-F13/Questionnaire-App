//
//  SingALongMenuViewController.h
//  QuestionaireApp
//
//  Created by Mohammad Doleh on 10/14/13.
//  Copyright (c) 2013 Tucker Cozzens. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "Constants.h"

@interface SingALongMenuViewController : UIViewController 
{
    IBOutlet UIButton *playPause;
    IBOutlet UIButton *stopButton;
    IBOutlet UILabel *playRecordingLabel;
    IBOutlet UIView *playStopButtonsContainer;
}
@property(nonatomic, retain) AVAudioPlayer *audioPlayer;
-(IBAction)playPausePlayback:(id)sender;
-(IBAction)stopPlayback:(id)sender;


@end

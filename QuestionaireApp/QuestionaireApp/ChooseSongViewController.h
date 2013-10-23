//
//  ChooseSongViewController.h
//  QuestionaireApp
//
//  Created by Mohammad Doleh on 10/14/13.
//  Copyright (c) 2013 Tucker Cozzens. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface ChooseSongViewController : UIViewController <MPMediaPickerControllerDelegate>
{
    IBOutlet UIButton *playPause;
    IBOutlet UISlider *volumeSlider;
}

@property MPMusicPlayerController *musicPlayer;

-(IBAction)cancelRecordNew:(id)sender;
-(IBAction)playPausePlayback:(id)sender;
-(IBAction)stopPlayback:(id)sender;
-(void)registerMediaPlayerNotifications;
-(IBAction)showMediaPicker:(id)sender;
-(IBAction)volumeChanged:(id)sender;

@end

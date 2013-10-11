//
//  MusicLibraryViewController.h
//  QuestionaireApp
//
//  Created by Andrew Kelley on 10/7/13.
//  Copyright (c) 2013 Tucker Cozzens. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface MusicLibraryViewController : UIViewController <MPMediaPickerControllerDelegate> {
    IBOutlet UISlider *volumeSlider;
    IBOutlet UIButton *playButton;
}

@property MPMusicPlayerController *musicPlayer;



- (IBAction)volumeChanged:(id)sender;
- (IBAction)showMediaPicker:(id)sender;
- (IBAction)playPause:(id)sender;
- (void) registerMediaPlayerNotifications;

@end

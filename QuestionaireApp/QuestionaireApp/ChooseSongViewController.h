//
//  ChooseSongViewController.h
//  QuestionaireApp
//
//  Created by Mohammad Doleh on 10/14/13.
//  Copyright (c) 2013 Tucker Cozzens. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface ChooseSongViewController : UIViewController <MPMediaPickerControllerDelegate>{
    
    MPMusicPlayerController *musicPlayer;
    
    IBOutlet UIImageView *artworkImageView;
    IBOutlet UILabel *titleLabel;
    IBOutlet UILabel *artistLabel;
    IBOutlet UILabel *albumLabel;
    IBOutlet UISlider *volumeSlider;
    IBOutlet UIButton *playPauseButton;
    
    
}
@property (nonatomic, retain) MPMusicPlayerController *musicPlayer;

- (IBAction)showMediaPicker:(id)sender;

- (IBAction)volumeChanged:(id)sender;

- (IBAction)previousSong:(id)sender;
- (IBAction)playPause:(id)sender;
- (IBAction)nextSong:(id)sender;
- (IBAction)cancel:(id)sender;

- (void) registerMediaPlayerNotifications;



@end

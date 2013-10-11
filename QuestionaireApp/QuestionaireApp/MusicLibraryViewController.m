//
//  MusicLibraryViewController.m
//  QuestionaireApp
//
//  Created by Andrew Kelley on 10/7/13.
//  Copyright (c) 2013 Tucker Cozzens. All rights reserved.
//

#import "MusicLibraryViewController.h"

@interface MusicLibraryViewController ()

@end

@implementation MusicLibraryViewController

@synthesize musicPlayer;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    musicPlayer = [MPMusicPlayerController iPodMusicPlayer];
    //[volumeSlider setValue:[musicPlayer volume]];
    [self registerMediaPlayerNotifications];
}

- (IBAction)volumeChanged:(id)sender {
    
}
- (IBAction)showMediaPicker:(id)sender
{
    MPMediaPickerController *mediaPicker = [[MPMediaPickerController alloc] initWithMediaTypes: MPMediaTypeMusic];
    mediaPicker.delegate = self;
    mediaPicker.allowsPickingMultipleItems = NO;
    mediaPicker.prompt = NSLocalizedString(@"Select Your Favorite Song!", nil);
    [mediaPicker loadView];
    [[self navigationController] presentViewController:mediaPicker animated:YES completion:nil];
}

- (IBAction)playPause:(id)sender {
    if ([musicPlayer playbackState] == MPMusicPlaybackStatePlaying) {
        [musicPlayer pause];
    } else {
        [musicPlayer play];
    }
}
- (void) registerMediaPlayerNotifications{
    
}



@end

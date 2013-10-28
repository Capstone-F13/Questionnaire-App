//
//  ChooseSongViewController.m
//  QuestionaireApp
//
//  Created by Mohammad Doleh on 10/14/13.
//  Copyright (c) 2013 Tucker Cozzens. All rights reserved.
//

#import "ChooseSongViewController.h"
#import "Constants.h"

@interface ChooseSongViewController ()

@end

@implementation ChooseSongViewController

@synthesize musicPlayer;

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
	
    musicPlayer = [MPMusicPlayerController iPodMusicPlayer];
    //[volumeSlider setValue:[musicPlayer volume]];
    [self registerMediaPlayerNotifications];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)cancelRecordNew:(id)sender
{
    // Dismiss the view and return the Sing-a-long menu
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(IBAction)playPausePlayback:(id)sender
{
    UIImage *icon;
    if ([musicPlayer playbackState] == MPMusicPlaybackStatePlaying)
    {
        // Set button image to pause icon
        icon = [UIImage imageNamed:PAUSE_ICON];
        
        [musicPlayer pause];
    }
    else
    {
        // Set button image to play icon
        icon = [UIImage imageNamed:PLAY_ICON];
        
        [musicPlayer play];
    }
    [playPause setImage:icon forState:UIControlStateNormal];
}

-(IBAction)stopPlayback:(id)sender
{
    [musicPlayer stop];
}

-(IBAction)volumeChanged:(id)sender
{
    
}

-(IBAction)showMediaPicker:(id)sender
{
    MPMediaPickerController *mediaPicker = [[MPMediaPickerController alloc] initWithMediaTypes: MPMediaTypeMusic];
    mediaPicker.delegate = self;
    mediaPicker.allowsPickingMultipleItems = NO;
    mediaPicker.prompt = NSLocalizedString(@"Select Your Favorite Song!", nil);
    [mediaPicker loadView];
    [[self navigationController] presentViewController:mediaPicker animated:YES completion:nil];
}

- (void) mediaPickerDidCancel: (MPMediaPickerController *) mediaPicker
{
	[self dismissViewControllerAnimated:true completion:nil];
}

- (void) registerMediaPlayerNotifications
{
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    
	[notificationCenter addObserver: self
						   selector: @selector (handle_NowPlayingItemChanged:)
							   name: MPMusicPlayerControllerNowPlayingItemDidChangeNotification
							 object: musicPlayer];
	
	[notificationCenter addObserver: self
						   selector: @selector (handle_PlaybackStateChanged:)
							   name: MPMusicPlayerControllerPlaybackStateDidChangeNotification
							 object: musicPlayer];
    
    [notificationCenter addObserver: self
						   selector: @selector (handle_VolumeChanged:)
							   name: MPMusicPlayerControllerVolumeDidChangeNotification
							 object: musicPlayer];
    
	[musicPlayer beginGeneratingPlaybackNotifications];
}

- (void) handle_NowPlayingItemChanged: (id) notification
{
   	MPMediaItem *currentItem = [musicPlayer nowPlayingItem];
	UIImage *artworkImage = [UIImage imageNamed:@"noArtworkImage.png"];
	MPMediaItemArtwork *artwork = [currentItem valueForProperty: MPMediaItemPropertyArtwork];
	
	if (artwork) {
		artworkImage = [artwork imageWithSize: CGSizeMake (200, 200)];
	}
	
    //[artworkImageView setImage:artworkImage];
    
    NSString *titleString = [currentItem valueForProperty:MPMediaItemPropertyTitle];
    if (titleString) {
        songTitle.text = [NSString stringWithFormat:@"Title: %@",titleString];
    } else {
        songTitle.text = @"Title: Unknown title";
    }
    
    NSString *artistString = [currentItem valueForProperty:MPMediaItemPropertyArtist];
    if (artistString) {
        songArtist.text = [NSString stringWithFormat:@"Artist: %@",artistString];
    } else {
        songArtist.text = @"Artist: Unknown artist";
    }
    
    NSString *albumString = [currentItem valueForProperty:MPMediaItemPropertyAlbumTitle];
    if (albumString) {
        songAlbum.text = [NSString stringWithFormat:@"Album: %@",albumString];
    } else {
        songAlbum.text = @"Album: Unknown album";
    }
    
    
}


- (void) handle_PlaybackStateChanged: (id) notification
{
    MPMusicPlaybackState playbackState = [musicPlayer playbackState];
	
	if (playbackState == MPMusicPlaybackStatePaused) {
        [playPause setImage:[UIImage imageNamed:@"play_button.png"] forState:UIControlStateNormal];
        
        
	} else if (playbackState == MPMusicPlaybackStatePlaying) {
        [playPause setImage:[UIImage imageNamed:@"pause_button.png"] forState:UIControlStateNormal];
        
	} else if (playbackState == MPMusicPlaybackStateStopped) {
        
        [playPause setImage:[UIImage imageNamed:@"play_button.png"] forState:UIControlStateNormal];
		[musicPlayer stop];
        
	}
    
}


@end

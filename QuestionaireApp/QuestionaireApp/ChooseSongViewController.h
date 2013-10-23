//
//  ChooseSongViewController.h
//  QuestionaireApp
//
//  Created by Mohammad Doleh on 10/14/13.
//  Copyright (c) 2013 Tucker Cozzens. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseSongViewController : UIViewController
{
    IBOutlet UIButton *playPause;
}

-(IBAction)cancelRecordNew:(id)sender;
-(IBAction)playPausePlayback:(id)sender;
-(IBAction)stopPlayback:(id)sender;

@end

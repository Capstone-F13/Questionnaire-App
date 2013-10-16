//
//  RecordViewController.h
//  QuestionaireApp
//
//  Created by Mohammad Doleh on 10/14/13.
//  Copyright (c) 2013 Tucker Cozzens. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

@interface RecordViewController : UIViewController
{
    IBOutlet UIButton *playPause;
    IBOutlet UIButton *record;
}

-(IBAction)playPausePlayback:(id)sender;
-(IBAction)stopPlayback:(id)sender;
-(IBAction)startStopRecording:(id)sender;
-(IBAction)cancelRecordNew:(id)sender;
-(IBAction)finishRecordNew:(id)sender;

@end

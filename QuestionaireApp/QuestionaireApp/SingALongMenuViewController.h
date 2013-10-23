//
//  SingALongMenuViewController.h
//  QuestionaireApp
//
//  Created by Mohammad Doleh on 10/14/13.
//  Copyright (c) 2013 Tucker Cozzens. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

@interface SingALongMenuViewController : UIViewController
{
    IBOutlet UIButton *playPause;
}

-(IBAction)playPausePlayback:(id)sender;
-(IBAction)stopPlayback:(id)sender;

@end

//
//  Constants.h
//  QuestionaireApp
//
//  Created by Mohammad Doleh on 10/14/13.
//  Copyright (c) 2013 Tucker Cozzens. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Constants : NSObject

// Constants with locations to play/pause images
extern NSString *const PLAY_ICON;
extern NSString *const PAUSE_ICON;
extern NSString *const RECORD_ICON;
extern NSString *const CURRENTLY_RECORDING_ICON;
extern NSString *const SERVER_ADDRESS;
extern NSString *const DEFAULTS_AUTH_TOKEN;
extern NSString *const DEFAULTS_PATIENT_ID;
extern NSString *const DEFAULTS_PATIENTS;
extern NSString *const DEFAULTS_CURRENT_SURVEY;
extern NSString *const DEFAULTS_TIME_SURVEY_SENT;
extern NSString *const DEFAULTS_PARAMETERS_ARRAY;
extern NSString *const DEFAULTS_TIME_SONG_RECORDED;

extern double const MINIMUM_WAIT_FOR_NEXT_SURVEY;
extern double const MINIMUM_WAIT_FOR_NEXT_SONG;

extern bool *SURVEY_TAKEN;

@end

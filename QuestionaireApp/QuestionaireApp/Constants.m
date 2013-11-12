//
//  Constants.m
//  QuestionaireApp
//
//  Created by Mohammad Doleh on 10/14/13.
//  Copyright (c) 2013 Tucker Cozzens. All rights reserved.
//

#import "Constants.h"

@implementation Constants

// Constants with locations to play/pause images
NSString *const PLAY_ICON = @"play_button.png";
NSString *const PAUSE_ICON = @"pause_button.png";
NSString *const RECORD_ICON = @"record_button.png";
NSString *const CURRENTLY_RECORDING_ICON = @"currently_recording_button.png";
NSString *const SERVER_ADDRESS = @"http://create.cs.kent.edu"; // 10.14.219.188:8001
NSString *const DEFAULTS_AUTH_TOKEN = @"authToken";
NSString *const DEFAULTS_PATIENT_ID = @"patientID";
NSString *const DEFAULTS_PATIENTS = @"patients";
NSString *const DEFAULTS_CURRENT_SURVEY = @"currentSurvey";
NSString *const DEFAULTS_TIME_SURVEY_SENT = @"timeSurveySent";
NSString *const DEFAULTS_PARAMETERS_ARRAY = @"parametersArray";

double const MINIMUM_WAIT_FOR_NEXT_SURVEY = 5 * 60; // 5 minutes

bool *SURVEY_TAKEN = false;

@end

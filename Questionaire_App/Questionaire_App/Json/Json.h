//
//  Json.h
//  Questionaire-App
//
//  Created by Adam Esterle on 9/16/13.
//  Copyright (c) 2013 Adam Esterle. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import "SurveyConstants.h"
#import "Survey.h"
#import "JsonResponse.h"

@interface Json : NSObject

-(void) request;
-(void) parse;
-(JsonResponse*) createTestResponse;
-(Survey*) createTestSurvey;

@end
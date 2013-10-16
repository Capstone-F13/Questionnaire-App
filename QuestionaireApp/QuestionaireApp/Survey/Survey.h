//
//  Survey.h
//  Questionaire_App
//
//  Created by Adam Esterle on 9/18/13.
//  Copyright (c) 2013 Adam Esterle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SurveyConstants.h"
#import "Question.h"

@interface Survey : NSObject

@property (nonatomic, strong) NSMutableArray *questions;

+ (id)surveyWithJSON:(NSDictionary *)JSON;

@end
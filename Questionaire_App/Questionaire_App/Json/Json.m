//
//  Json.m
//  Questionaire-App
//
//  Created by Adam Esterle on 9/16/13.
//  Copyright (c) 2013 Adam Esterle. All rights reserved.
//
//

#import "Json.h"
#import "JsonResponse.h"
#import "SurveyConstants.h"
#import "Survey.h"

@implementation Json

-(void) request {
    
}

-(void) parse {
    
    //JsonResponse *response = [[JsonResponse alloc] init];
    JsonResponse *response = [self createTestResponse];
    
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:[response data] options:kNilOptions error:nil];
}

-(JsonResponse*) createTestResponse {
    
    Survey *survey = [self createTestSurvey];
    
    //gotta convert survey to give JSON object what it wants...
    
    JsonResponse *response = [[JsonResponse alloc] init];
    response.failureCode = nil;
    response.failureMessage = @"";
    response.promptMessage = @"Please take this survey";
    response.data = [NSJSONSerialization dataWithJSONObject:survey options:kNilOptions error:nil];
    response.status = 200;
    response.timestamp = [[NSDate date] timeIntervalSince1970];
    
    return response;
}

-(Survey*) createTestSurvey {
    Survey *survey = [[Survey alloc] init];
    
    survey.questions = [[NSMutableArray alloc] init];
    
    {
        Question *question = [[Question alloc] init];
        question.questionId = 13;
        question.text = @"How you feeling, braj?";
        question.type = @"text";
        question.answers = nil;
        [survey.questions addObject:question];
    }
    {
        Question *question = [[Question alloc] init];
        question.questionId = 66;
        question.text = @"3 + 10 = ?";
        question.type = @"multiple";
        
        NSMutableDictionary *answers = [[NSMutableDictionary alloc] init];
        [answers setObject:@"7" forKey:@"a"];
        [answers setObject:@"13" forKey:@"b"];
        [answers setObject:@"30" forKey:@"c"];
        [answers setObject:@"310" forKey:@"d"];
        question.answers = answers;
        
        [survey.questions addObject:question];
    }
    
    return survey;
}

@end
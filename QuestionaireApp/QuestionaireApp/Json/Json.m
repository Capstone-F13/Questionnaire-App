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

-(void) debuggingSurvey {
    
    //response with JSON string
//    JsonResponse *response = [self createTestResponse];
    
    //Parse JSON string into foundation objects
//    NSData *jsonData = [response.data dataUsingEncoding:NSUTF8StringEncoding];
//    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData
//                                                               options:NSJSONReadingMutableContainers
//                                                                 error:nil];
//    
    //Parse foundation objects into custom objects
//    Survey *survey = [self getSurveyFromJSON:jsonObject];
}

-(void) requestSurvey {
    
}

-(void) parseJSONintoFoundationObjects {
    
}

-(void) parseFoundationObjectsIntoSurvey {
    
}

-(Survey*) getSurveyFromJSON: (NSDictionary*) jsonObject{
    Survey *survey = [[Survey alloc] init];
    
    survey.questions = [self getQuestionsFromJSON:jsonObject];
    
    return survey;
}

-(NSMutableArray*) getQuestionsFromJSON: (NSDictionary*) jsonObject{
    NSMutableArray *questions = [[NSMutableArray alloc] init];

    NSMutableArray *jsonQuestions = [[jsonObject objectForKey:SURVEY] objectForKey:QUESTIONS];
    
    for (NSDictionary *jsonQuestion in jsonQuestions) {
        Question *question = [[Question alloc] init];
//        question.questionId = [jsonQuestion objectForKey:QUESTION_ID];
        question.text = [jsonQuestion objectForKey:QUESTION_TEXT];
//        question.type = [jsonQuestion objectForKey:QUESTION_TYPE];
//        question.answers = [jsonQuestion objectForKey:QUESTION_ANSWERS];
        [questions addObject:question];
    }
    
    return questions;
}

-(JsonResponse*) createTestResponse {
    
    JsonResponse *response = [[JsonResponse alloc] init];
    response.failureCode = nil;
    response.failureMessage = @"";
    response.promptMessage = @"Please take this survey";
    response.data = @""
    "{"
        "\"survey\" : {"
            "\"questions\":["
                "{"
                    "\"id\" : 66,"
                    "\"text\" : \"Which best describes you?\","
                    "\"type\" : \"multiple\","
                    "\"answers\" : {"
                        "\"a\" : \"Happy\","
                        "\"b\" : \"Sad\","
                        "\"c\" : \"Extremely Depressed\","
                        "\"d\" : \"Apathetic\""
                    "}"
                "},"
                "{"
                    "\"id\" : 67,"
                    "\"text\" : \"How you feeling in one word?\","
                    "\"type\" : \"text\","
                    "\"answers\" : {}"
                "}"
            "]"
        "}"
    "}";
    response.status = 200;
    response.timestamp = [[NSDate date] timeIntervalSince1970];
    
    return response;
}

-(Survey*) createTestSurvey {
    Survey *survey = [[Survey alloc] init];
    
    survey.questions = [[NSMutableArray alloc] init];
    
    {
        Question *question = [[Question alloc] init];
//        question.questionId = [NSNumber numberWithInt:13];
        question.text = @"How you feeling, braj?";
//        question.type = @"text";
        question.answers = nil;
        [survey.questions addObject:question];
    }
    {
        Question *question = [[Question alloc] init];
//        question.questionId = [NSNumber numberWithInt:66];;
        question.text = @"3 + 10 = ?";
//        question.type = @"multiple";
        
        NSMutableDictionary *answers = [[NSMutableDictionary alloc] init];
        [answers setObject:@"7" forKey:@"a"];
        [answers setObject:@"13" forKey:@"b"];
        [answers setObject:@"30" forKey:@"c"];
        [answers setObject:@"310" forKey:@"d"];
//        question.answers = answers;
        
        [survey.questions addObject:question];
    }
    
    return survey;
}

@end
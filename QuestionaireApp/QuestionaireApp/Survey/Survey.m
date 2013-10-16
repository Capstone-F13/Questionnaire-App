//
//  Survey.m
//  Questionaire_App
//
//  Created by Adam Esterle on 9/18/13.
//  Copyright (c) 2013 Adam Esterle. All rights reserved.
//

#import "Survey.h"
#import "SurveyConstants.h"
#import "Question.h"
#import "Answer.h"

@implementation Survey

+ (id)surveyWithJSON:(NSDictionary *)JSON {
    return [[Survey alloc] initWithJSON:JSON];
}


- (id)initWithJSON:(NSDictionary *)JSON {
    if (self = [super init]) {

        self.questions = [NSMutableArray new];
        
        NSArray *questions = JSON[@"objects"];
        for (NSDictionary *q in questions) {
            
            BOOL isMultipleChoice = [q[@"is_multiple_choice"] isEqualToNumber:@1];
            
            Question *question = [Question questionWithID:[q[@"id"] integerValue]
                                                     text:q[@"question"]
                                         isMultipleChoice:isMultipleChoice];
            
            if (isMultipleChoice) {
                
                NSArray *answers = q[@"answers"];
                for (NSDictionary *a in answers) {
                    
                    Answer *answer = [Answer answerWithID:[a[@"id"] integerValue]
                                                     text:a[@"text"]];
                    
                    [question.answers addObject:answer];
                }
                
            }
            
            [self.questions addObject:question];
        }
    }
    return self;
}


@end
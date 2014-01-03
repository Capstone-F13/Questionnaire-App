//
//  Question.m
//  Questionaire_App
//
//  Created by Adam Esterle on 9/18/13.
//  Copyright (c) 2013 Adam Esterle. All rights reserved.
//

#import "Question.h"
#import "SurveyConstants.h"

@implementation Question

+ (id)questionWithID:(NSUInteger)questionID text:(NSString *)text isMultipleChoice:(BOOL)isMultipleChoice isAscendingPositivity:(BOOL)isAscendingPositivity survey:(NSUInteger)surveyID {
    return [[Question alloc] initWithID:questionID text:text isMultipleChoice:isMultipleChoice isAscendingPositivity:isAscendingPositivity survey:surveyID];
}

- (id)initWithID:(NSUInteger)questionID text:(NSString *)text isMultipleChoice:(BOOL)isMultipleChoice isAscendingPositivity:(BOOL)isAscendingPositivity survey:(NSUInteger)surveyID {
    if (self = [super init]) {
        self.questionID = questionID;
        self.text = text;
        self.isMultipleChoice = isMultipleChoice;
        self.isAscendingPositivity = isAscendingPositivity;
        self.answers = [NSMutableArray new];
        self.answerText = nil;
        self.surveyID = surveyID;
    }
    return self;
}

@end

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

+ (id)questionWithID:(NSUInteger)questionID text:(NSString *)text isMultipleChoice:(BOOL)isMultipleChoice {
    return [[Question alloc] initWithID:questionID text:text isMultipleChoice:isMultipleChoice];
}

- (id)initWithID:(NSUInteger)questionID text:(NSString *)text isMultipleChoice:(BOOL)isMultipleChoice {
    if (self = [super init]) {
        self.questionID = questionID;
        self.text = text;
        self.isMultipleChoice = isMultipleChoice;
        self.answers = [NSMutableArray new];
    }
    return self;
}

@end

//
//  Question.h
//  Questionaire_App
//
//  Created by Adam Esterle on 9/18/13.
//  Copyright (c) 2013 Adam Esterle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SurveyConstants.h"

@interface Question : NSObject

@property (nonatomic, assign) NSUInteger questionID;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, assign) BOOL isMultipleChoice;
@property (nonatomic, strong) NSMutableArray *answers;
@property (nonatomic, strong) NSString *answerText;
@property (nonatomic, assign) NSUInteger surveyID;

+ (id)questionWithID:(NSUInteger)questionID text:(NSString *)text isMultipleChoice:(BOOL)isMultipleChoice survey:(NSUInteger)surveyID;

@end
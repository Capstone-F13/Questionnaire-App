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

@property int questionId;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSMutableDictionary *answers;

@end

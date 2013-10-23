//
//  Answer.h
//  QuestionaireApp
//
//  Created by David Steinberg on 10/15/13.
//  Copyright (c) 2013 Tucker Cozzens. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Answer : NSObject

@property (assign) NSUInteger answerID;
@property (strong) NSString *text;

+ (id)answerWithID:(NSUInteger)answerID text:(NSString *)text;

@end

//
//  Answer.m
//  QuestionaireApp
//
//  Created by David Steinberg on 10/15/13.
//  Copyright (c) 2013 Tucker Cozzens. All rights reserved.
//

#import "Answer.h"

@implementation Answer

+ (id)answerWithID:(NSUInteger)answerID text:(NSString *)text {
    return [[Answer alloc] initWithID:answerID text:text];
}

- (id)initWithID:(NSUInteger)answerID text:(NSString *)text {
    if (self = [super init]) {
        self.answerID = answerID;
        self.text = text;
    }
    return self;
}

@end

//
//  User.m
//  QuestionaireApp
//
//  Created by Adam Esterle on 10/7/13.
//  Copyright (c) 2013 Adam Esterle. All rights reserved.
//

#import "User.h"
#import "JsonResponse.h"

@implementation User
@synthesize patientId, username, password;


- (void) authenticateWithPatientId:(NSString *)patientId
                          Username:(NSString *)username
                          Password:(NSString *)password{
    
    NSLog(@"here");
    
    JsonResponse *response = [[JsonResponse alloc] init];
    response.failureCode = nil;
    response.failureMessage = @"";
    response.promptMessage = @"Please take this survey";
    response.data = @""
    "{"
        "\"user\" : {"
            "\"patientId\" : 66,"
            "\"username\" : \"psych\","
            "\"password\" : \"rambo\""
        "}"
    "}";
    response.status = 200;
    response.timestamp = [[NSDate date] timeIntervalSince1970];
    
    //return response;
    
}

@end

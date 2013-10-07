//
//  User.m
//  QuestionaireApp
//
//  Created by Adam Esterle on 10/7/13.
//  Copyright (c) 2013 Adam Esterle. All rights reserved.
//

#import "User.h"

@implementation User
@synthesize patientId, username, password;


- (void) authenticateWithPatientId:(NSString *)patientId
                          Username:(NSString *)username
                          Password:(NSString *)password{
    
    NSLog(@"here");
    
}

@end

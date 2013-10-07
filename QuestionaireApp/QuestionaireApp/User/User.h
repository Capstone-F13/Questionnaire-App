//
//  User.h
//  QuestionaireApp
//
//  Created by Adam Esterle on 10/7/13.
//  Copyright (c) 2013 Adam Esterle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, weak) NSString *patientId;
@property (nonatomic, weak) NSString *username;
@property (nonatomic, weak) NSString *password;

- (void) authenticateWithPatientId: (NSString*) patientId
                          Username: (NSString*) username
                          Password: (NSString*) password;

@end

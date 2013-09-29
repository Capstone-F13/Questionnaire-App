//
//  JsonResponse.h
//  Questionaire-App
//
//  Created by Adam Esterle on 9/16/13.
//  Copyright (c) 2013 Adam Esterle. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import "SurveyConstants.h"

@interface JsonResponse : NSObject

@property (nonatomic, strong) NSString *failureCode;
@property (nonatomic, strong) NSString *failureMessage;
@property (nonatomic, strong) NSString *promptMessage;

@property (nonatomic, strong) NSData *data;
@property int status;
@property int timestamp;

@end
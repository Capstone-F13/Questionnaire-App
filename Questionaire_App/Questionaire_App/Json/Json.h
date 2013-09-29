//
//  Json.h
//  Questionaire-App
//
//  Created by Adam Esterle on 9/16/13.
//
//

#import <Foundation/Foundation.h>

@interface Json : NSObject

-(void) request;
-(void) parse;

@end

-(JsonResponse*) createTestResponse;
-(Survey*) createTestSurvey;

@end
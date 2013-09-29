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
<<<<<<< HEAD

@end

=======
>>>>>>> parent of b69bd3c... Merge branch 'json_live' into Development
-(JsonResponse*) createTestResponse;
-(Survey*) createTestSurvey;

@end
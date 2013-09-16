//
//  Json.m
//  Questionaire-App
//
//  Created by Adam Esterle on 9/16/13.
//
//

#import "Json.h"
#import "JsonResponse.h"

@implementation Json

-(void) request {
    
}

-(void) parse {
    JsonResponse *response = [[JsonResponse alloc] init];
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:[response data] options:kNilOptions error:nil];
}

@end

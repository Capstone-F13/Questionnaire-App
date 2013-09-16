//
//  JsonResponse.h
//  Questionaire-App
//
//  Created by Adam Esterle on 9/16/13.
//
//

#import <Foundation/Foundation.h>

@interface JsonResponse : NSObject

@property (nonatomic, strong) NSString *failureCode;
@property (nonatomic, strong) NSString *failureMessage;
@property (nonatomic, strong) NSString *promptMessage;

@property (nonatomic, strong) NSData *data;
@property int status;
@property int timestamp;

@end

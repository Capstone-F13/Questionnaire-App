//
//  AdminViewController.h
//  QuestionaireApp
//
//  Created by Andrew Kelley on 10/3/13.
//  Copyright (c) 2013 Tucker Cozzens. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdminViewController : UIViewController

@property (nonatomic, strong) IBOutlet UITextField *patientId;
@property (nonatomic, strong) IBOutlet UITextField *adminUsername;
@property (nonatomic, strong) IBOutlet UITextField *password;
@property (nonatomic, weak) IBOutlet UILabel *error;
@property BOOL hasError;

- (IBAction)submit:(id)sender;
- (IBAction)cancel:(id)sender;
- (Boolean)checkPasswordsNotNull:(NSString *)password1;
- (void)setErrorMessage:(NSString *)message;

- (void) authenticateUser;

@end

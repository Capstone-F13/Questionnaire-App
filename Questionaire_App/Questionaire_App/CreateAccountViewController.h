//
//  CreateAccountViewController.h
//  Questionaire_App
//
//  Created by Andrew Kelley on 9/28/13.
//  Copyright (c) 2013 Tucker Cozzens. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateAccountViewController : UIViewController

@property (nonatomic, strong) IBOutlet UITextField *userName;
@property (nonatomic, strong) IBOutlet UITextField *password;
@property (nonatomic, strong) IBOutlet UITextField *confirmPassword;
@property (nonatomic, weak) IBOutlet UILabel *error;

- (IBAction)submit:(id)sender;
- (Boolean)checkPasswordsMatch:(NSString *)password1
                              :(NSString *)password2;
- (Boolean)checkPasswordsNotNull:(NSString *)password1
                              :(NSString *)password2;
- (void)setErrorMessage:(NSString *)message;

@end

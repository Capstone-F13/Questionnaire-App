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

- (IBAction)submit:(id)sender;

@end

//
//  QuestionaireViewController.h
//  Questionaire_App
//
//  Created by Tucker Cozzens on 9/18/13.
//  Copyright (c) 2013 Tucker Cozzens. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionaireViewController : UIViewController
{
    IBOutlet UILabel *currentQuestion;
    IBOutlet UITextView *answerQuestion;
}
-(IBAction)nextQuestion:(id)sender;
-(IBAction)previousQuestion:(id)sender;

@end

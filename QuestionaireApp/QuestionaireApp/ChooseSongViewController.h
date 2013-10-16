//
//  ChooseSongViewController.h
//  QuestionaireApp
//
//  Created by Mohammad Doleh on 10/14/13.
//  Copyright (c) 2013 Tucker Cozzens. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseSongViewController : UIViewController
{
    IBOutlet UITableView *songTableView;
}

-(IBAction)cancelRecordNew:(id)sender;

@end

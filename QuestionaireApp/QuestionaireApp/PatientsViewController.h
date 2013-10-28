//
//  PatientsViewController.h
//  QuestionaireApp
//
//  Created by Mohammad Doleh on 10/23/13.
//  Copyright (c) 2013 Tucker Cozzens. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PatientsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *patientTable;

@end

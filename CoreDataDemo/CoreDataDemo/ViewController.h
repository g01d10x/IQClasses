//
//  ViewController.h
//  CoreDataDemo
//
//  Created by Mohd Iftekhar Qurashi on 01/07/13.
//  Copyright (c) 2013 Canopus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    NSArray *arrayRecords;
    
    IBOutlet UITextField *textFieldName;
    IBOutlet UITextField *textFieldNumber;
    
    IBOutlet UITableView *tableViewRecord;
}

- (IBAction)saveClicked:(id)sender;

@end

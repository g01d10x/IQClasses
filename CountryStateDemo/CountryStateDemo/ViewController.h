//
//  ViewController.h
//  CountryStateDemo
//
//  Created by Mohd Iftekhar Qurashi on 23/06/13.
//  Copyright (c) 2013 Canopus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    IBOutlet UITableView *tableViewCountry;
    IBOutlet UITableView *tableViewStates;
    
    NSArray *countriesList;
    NSArray *statesForCurrentCountry;
}
@end

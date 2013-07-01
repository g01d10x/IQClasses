//
//  ViewController.m
//  CoreDataDemo
//
//  Created by Mohd Iftekhar Qurashi on 01/07/13.
//  Copyright (c) 2013 Canopus. All rights reserved.
//

#import "ViewController.h"
#import "CoreDataHelper.h"

@implementation ViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    arrayRecords = [[CoreDataHelper helper] getAllRecord];
	// Do any additional setup after loading the view, typically from a nib.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrayRecords count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    
    [cell.textLabel setText:[[arrayRecords objectAtIndex:indexPath.row] objectForKey:RECORD_NAME]];
    [cell.detailTextLabel setText:[[[arrayRecords objectAtIndex:indexPath.row] objectForKey:RECORD_NUMBER] stringValue]];

    return cell;
}

- (void)viewDidUnload
{
    textFieldName = nil;
    textFieldNumber = nil;
    tableViewRecord = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)saveClicked:(id)sender
{
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:
                          textFieldName.text,RECORD_NAME,
                          [NSNumber numberWithInteger:[textFieldNumber.text integerValue]],RECORD_NUMBER, nil];
    [[CoreDataHelper helper] saveRecord:dict];
    arrayRecords = [[CoreDataHelper helper] getAllRecord];
    [tableViewRecord reloadData];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end

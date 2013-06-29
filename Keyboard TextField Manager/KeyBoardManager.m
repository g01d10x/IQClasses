//
//  keyBoardManager.m
//  AutoRepair
//
//  Created by Gaurav Goyal on 2/14/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.


#import "KeyBoardManager.h"
#import "CustomSegmentedControl.h"

@implementation KeyBoardManager
@synthesize scrollView;

-(void)adjustKeyBoardForTextField:(UITextField*)textField
{
    [scrollView setScrollEnabled:NO];
    //216 is keyboard height.
    //If input accessoryView is present then it's height. otherwise it will return zero.
    //30 for gap maintainance between textField/textView and keyboard.
    CGFloat kbHeight = 216+CGRectGetHeight(textField.inputAccessoryView.bounds)+10;
    
    if (isRestored == YES)
        scrollViewOffset = scrollView.contentOffset;

    //Calculating view frame according to window.
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
//    CGRect rect = [keyWindow convertRect:textField.frame fromView:scrollView];
    CGRect rect = [textField.superview convertRect:textField.frame toView:keyWindow];
    
    //1st condition: If KeyBoard hide current view, then restoring view.
    //2nd condition: If keyboard is not restored(Not hide a single time, Just moving to another textField manually). Then moving textField to just top of keyboard
    if((CGRectGetMaxY(rect)>CGRectGetMaxY(keyWindow.frame)-kbHeight) || isRestored == NO)
    {
        //Calculate movement which should be scrolled.
        float move = CGRectGetMaxY(rect)-(CGRectGetMaxY(keyWindow.frame)-kbHeight);
//        float distanceFromStatusBar = CGRectGetMinY(rect)-CGRectGetHeight([[UIApplication sharedApplication] statusBarFrame]);
        
        //Suppose that textview height is too big. so
        //Finding which distance is short
        //Distance from status bar to Y of View < calculated movement.
        
        //moving scrollView's contentOffset.
        //        [scrollView setContentOffset:CGPointMake(0, scrollViewOffset.y+distanceFromStatusBar<move?distanceFromStatusBar:move) animated:YES];
        [scrollView setContentOffset:CGPointMake(0, scrollView.contentOffset.y+move) animated:YES];
    }
    
    isRestored = NO;
}

-(void)restoreKeyBoard
{
    isRestored = YES;
    [scrollView setScrollEnabled:YES];
    [scrollView setContentOffset:scrollViewOffset animated:YES];
    scrollViewOffset = CGPointZero;
}


+(void)addDoneButtonOnKeyboard:(UITextField*)textField target:(id)target action:(SEL)action
{
    //Creating a toolBar for phoneNumber keyboard
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    [toolbar setBarStyle:UIBarStyleBlackTranslucent];
    [toolbar sizeToFit];
    
    //Create a button to show on phoneNumber keyboard to resign it. Adding a selector to resign it.
    UIBarButtonItem *doneButton =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:target action:action];
    
    //Create a fake button to maintain flexibleSpace between doneButton and nilButton. (Actually it moves done button to right side.
    UIBarButtonItem *nilButton =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    //Adding button to toolBar.
    [toolbar setItems:[NSArray arrayWithObjects: nilButton,doneButton, nil]];
    
    //Setting toolbar to textFieldPhoneNumber keyboard.
    [textField setInputAccessoryView:toolbar];
}

+(void)addPreviousNextDoneButtonOnKeyboard:(UITextField*)textField target:(id)target previousAction:(SEL)previousAction nextAction:(SEL)nextAction doneAction:(SEL)doneAction
{
    //Creating a toolBar for phoneNumber keyboard
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    [toolbar setBarStyle:UIBarStyleBlackTranslucent];
    [toolbar sizeToFit];

//    //Create a button to show on phoneNumber keyboard to resign it. Adding a selector to resign it.
    UIBarButtonItem *previousButton =[[UIBarButtonItem alloc] initWithTitle:@"Previous" style:UIBarButtonItemStyleBordered target:target action:previousAction];
////
////    //Create a button to show on phoneNumber keyboard to resign it. Adding a selector to resign it.
    UIBarButtonItem *nextButton =[[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleBordered target:target action:nextAction];
    
    
    //Create a fake button to maintain flexibleSpace between doneButton and nilButton. (Actually it moves done button to right side.
    UIBarButtonItem *nilButton =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    //Create a button to show on phoneNumber keyboard to resign it. Adding a selector to resign it.
    UIBarButtonItem *doneButton =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:target action:doneAction];

//    CustomSegmentedControl *segControl = [[CustomSegmentedControl alloc] initWithTarget:target previousSelector:previousAction nextSelector:nextAction];
//
//    UIBarButtonItem *segButton = [[UIBarButtonItem alloc] initWithCustomView:segControl];

    //Adding button to toolBar.
//    [toolbar setItems:[NSArray arrayWithObjects: segButton,nilButton,doneButton, nil]];
    [toolbar setItems:[NSArray arrayWithObjects: previousButton,nextButton,nilButton,doneButton, nil]];
    
    //Setting toolbar to textFieldPhoneNumber keyboard.
    [textField setInputAccessoryView:toolbar];
}

@end

//
//  KeyBoardManager.h
//  AutoRepair
//
//  Created by Gaurav Goyal on 2/14/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeyBoardManager : NSObject
{
    CGPoint scrollViewOffset;
    BOOL isRestored;
}
@property(nonatomic,assign)UIScrollView *scrollView;

-(void)adjustKeyBoardForTextField:(UITextField*)textField;
-(void)restoreKeyBoard;

+(void)addDoneButtonOnKeyboard:(UITextField*)textField target:(id)target action:(SEL)action;
+(void)addPreviousNextDoneButtonOnKeyboard:(UITextField*)textField target:(id)target previousAction:(SEL)previousAction nextAction:(SEL)nextAction doneAction:(SEL)doneAction;

@end

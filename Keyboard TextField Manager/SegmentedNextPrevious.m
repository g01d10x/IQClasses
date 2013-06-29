//
//  KeyboardNextPrevious.m
//  DKKeyboardView
//
//  Created by Mohd Iftekhar Qurashi on 06/06/13.
//  Copyright (c) 2013 Denis Kutlubaev. All rights reserved.
//

#import "SegmentedNextPrevious.h"

@implementation SegmentedNextPrevious

-(id)initWithTarget:(id)target previousSelector:(SEL)pSelector nextSelector:(SEL)nSelector
{
    self = [super initWithItems:[NSArray arrayWithObjects:@"Previous",@"Next",nil]];
    
    if (self)
    {
        [self setSegmentedControlStyle:UISegmentedControlStyleBar];
        [self setMomentary:YES];
        [self addTarget:self action:@selector(segmentedControlHandler:) forControlEvents:UIControlEventValueChanged];
        
        buttonTarget = target;
        previousSelector = pSelector;
        nextSelector = nSelector;
    }
    return self;
}

- (void)segmentedControlHandler:(SegmentedNextPrevious*)sender
{
    switch ([sender selectedSegmentIndex])
    {
            case 0:
        {
            [buttonTarget performSelector:previousSelector withObject:nil];
        }
            break;
            case 1:
        {
            [buttonTarget performSelector:nextSelector withObject:nil];
        }
            default:
                break;
    }
}


@end

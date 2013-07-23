//
//  CountryStateHandler.m
//  Wishlu
//
//  Created by Gaurav Goyal on 12/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.



#import "IQCountryStateHandler.h"

static NSDictionary *countryDictionary;
static NSDictionary *stateDictionary;

@implementation IQCountryStateHandler

+(void)initialize
{
    [super initialize];
    countryDictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource: @"Country" ofType: @"plist"]];
    stateDictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource: @"State" ofType: @"plist"]];
}

+(NSArray*)countries
{
    return [[countryDictionary allValues] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
}

+(NSArray*)statesForCountry:(NSString*)country
{
    return [[stateDictionary objectForKey:country] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
}

@end

//  CountryStateHandler.h
//  Created by Iftekhar Qurashi on 01/01/13.

#import <Foundation/Foundation.h>

@interface IQCountryStateHandler : NSObject

+(NSArray*)countries;
+(NSArray*)statesForCountry:(NSString*)country;

@end
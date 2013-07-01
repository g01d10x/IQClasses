//
//  DatabaseManager.h
//  Geo
//
//  Created by Canopus 10 on 4/17/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreDataDefinition.h"

//Created by Iftekhar. 17/4/13.
@interface CoreDataHelper : NSObject

//Commonly Used.
+(CoreDataHelper*)helper;
/********************/

-(NSArray*)getAllRecord;
-(void)saveRecord:(NSDictionary*)eventDict;

@end

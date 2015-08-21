//
//  hashObject.h
//  firstGame
//
//  Created by Carl Kruk on 1/24/15.
//  Copyright (c) 2015 Carl Kruk. All rights reserved.
//

@interface hashObject : NSObject

//-----BASIC DATA STRUCTURE TO HOLD PERTINENT INFORMATION IN OUR HASH TABLES, NOTHING TO SEE HERE

-(id) initHashObject:(NSMutableArray *) a array:(int) d;
-(NSMutableArray *) getArray;

@property NSMutableArray *array;

@end

//
//  hashTable.h
//  firstGame
//
//  Created by Carl Kruk on 1/24/15.
//  Copyright (c) 2015 Carl Kruk. All rights reserved.
//

#import "Node.h"
#import "hashObject.h"

//CRUDE HASHTABLE WITHOUT RESIZING ARRAY, COLLISIONS HANDLED WITH SEPERATE CHAINING

@interface hashTable : NSObject

@property NSMutableArray *hashArray; //ACTUAL TABLE

-(id) initHashTable:(int) initialSize; //CONSTRUCTOR THAT SETS UP WITH ARRAY SIZE
-(void) insertInto:(Node *) n; //INSERT OBJECT INTO HASH TABLE
-(void) deleteObject:(Node *) n; //REMOVE OBJECT FROM HASH TABLE
-(BOOL) checkForDuplicate:(Node *) n; //CHECK FOR DUPLICATES

@end

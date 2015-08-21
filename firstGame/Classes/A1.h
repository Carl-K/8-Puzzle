//
//  A1.h
//  firstGame
//
//  Created by Carl Kruk on 1/25/15.
//  Copyright (c) 2015 Carl Kruk. All rights reserved.
//

#import "Node.h"
#import "queue.h"
#import "boardTypes.h"
#import "hashTable.h"

//-----ESSENTIALLY THE SAME AS THE COMMENTS FOUND FOR DEPTH FIRST SEARCH CLASS, MORE COMPLETE IN DEPTH FIRST SEARCH CLASS FILES

@interface A1 : NSObject

-(id) initA1;
-(NSString *) a1Search:(Node *) n;

@property queue *a1Queue; //QUEUE
@property NSMutableArray *correctBoard;
@property hashTable *tableForQueue; //TWO HASH TABLES
@property hashTable *tableForPrevious;

@end

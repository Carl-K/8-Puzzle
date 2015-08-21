//
//  A2.h
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

@interface A2 : NSObject

-(id) initA2;
-(NSString *) a2Search:(Node *) n;

@property queue *a2Queue; //QUEUE
@property NSMutableArray *correctBoard;
@property hashTable *tableForQueue; //TWO HASH TABLES
@property hashTable *tableForPrevious;

@end

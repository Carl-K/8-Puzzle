//
//  greedyBestSearch.h
//  firstGame
//
//  Created by Carl Kruk on 1/25/15.
//  Copyright (c) 2015 Carl Kruk. All rights reserved.
//

#import "queue.h"
#import "Node.h"
#import "boardTypes.h"
#import "hashTable.h"

//-----ESSENTIALLY THE SAME AS THE COMMENTS FOUND FOR DEPTH FIRST SEARCH CLASS, MORE COMPLETE IN DEPTH FIRST SEARCH CLASS FILES

@interface greedyBestSearch : NSObject

-(id) initGreedyBestFirst;
-(NSString *) greedyBestFirst:(Node *) n;

@property queue *greedyBestFirstQueue; //QUEUE
@property NSMutableArray *correctBoard;
@property hashTable *tableForQueue; //TWO HASH TABLES
@property hashTable *tableForPrevious;

@end

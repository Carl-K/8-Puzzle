//
//  depthFirstSearch.h
//  firstGame
//
//  Created by Carl Kruk on 1/24/15.
//  Copyright (c) 2015 Carl Kruk. All rights reserved.
//

#import "cocos2d.h"
#import "cocos2d-ui.h"

#import "Node.h"
#import "stack.h"
#import "hashTable.h"

#import "boardTypes.h"

//-----DEPTH FIRST SEARCH-----

@interface depthFirstSearch : NSObject

-(id) initDepthFirstSearch; //constructor
-(NSString *) depthFirst:(Node *) n;  //depth first search, returns path the zero tile takes from initial state to goal state

@property stack *depthFirstStack;  //stack
@property NSMutableArray *correctBoard;  //corrct board configuration

@property hashTable *tableForStack;  //hash table for objects in stack
@property hashTable *tableForPrevious; //hash table for nodes previously visited

@end
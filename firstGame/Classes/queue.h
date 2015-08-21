//
//  queue.h
//  firstGame
//
//  Created by Carl Kruk on 1/17/15.
//  Copyright (c) 2015 Carl Kruk. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Node.h"

#import "manhattanDistance.h"

@interface queue : NSObject

//-----GENERIC QUEUE FOR BREADTH FIRST SEARCHES-----

@property Node *first;
@property Node *last;

-(id) initQueue; //CONSTUCTOR

-(void) enqueue:(Node *) newLast;
-(Node *) dequeue;
-(BOOL) isEmpty; //IS THE QUEUE EMPTY?
-(int) getMaxSizeSeen; //RETURNS MAX SIZE OF QUEUE HAD
-(int) getQueueSize; //RETURNS CURRENT SIZE OF QUEUE

-(void) sortByManhattanDistance; //insertion sort for greedy best
-(void) sortByFOfNManhattan; //for A*2
-(void) sortByFOfNMisplaced; //for A*1

@property int sizeOf; //STORES CURRENT AMOUNT OF OBJECTS STORED IN QUEUE
@property int maxSizeSeen; //STORES MAX AMOUNT OF OBJECTS STORED IN QUEUE

@end

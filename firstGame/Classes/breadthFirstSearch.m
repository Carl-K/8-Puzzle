//
//  breadthFirstSearch.m
//  firstGame
//
//  Created by Carl Kruk on 1/24/15.
//  Copyright (c) 2015 Carl Kruk. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "breadthFirstSearch.h"

@implementation breadthFirstSearch
@synthesize breadthFirstQueue, correctBoard, tableForQueue, tableForPrevious;

-(id) initBreadthFirstSearch
{
    self.breadthFirstQueue = [[queue alloc] initQueue];
    self.correctBoard = [[[boardTypes alloc] initBoardTypes] getCorrectArray];
    self.tableForQueue = [[hashTable alloc] initHashTable:29];
    self.tableForPrevious = [[hashTable alloc] initHashTable:29];
    return self;
}

-(NSString *) breadthFirst:(Node *) n
{
    [self.breadthFirstQueue enqueue:n];  //INSERT INITIAL OBJECT TO QUEUE
    [self.tableForQueue insertInto:n];
    
    Node *board;
    
    while(![self.breadthFirstQueue isEmpty])
    {
        //DEQUEUES BOARD AND UPDATES HASH TABLE THAT STORES PREVIOUSLY SEEN BOARDS
        board = [self.breadthFirstQueue dequeue]; //points to board, does not make a copy
        [self.tableForPrevious insertInto:board];
        [self.tableForQueue deleteObject:board];
        
        if ([board compareBoards:self.correctBoard])
        {
            break;
        }
        
        //makes a move for all directions the 0 tile can go
        if ([board zeroLocation].x > 0)
        {
            Node *temp = [self generateMove:[board getBoard] array:[board getIteration] depth:[board getZeroLocation] zeroLocation:[board getMoves] moves:@"U"];
            //[self.breadthFirstQueue enqueue:temp];
            
            if (![self.tableForPrevious checkForDuplicate:temp]) //IF OBJECT NOT PREVIOUSLY SEEN
            {
                if (![self.tableForQueue checkForDuplicate:temp]) //IF OBJECT NOT CURRNTLY IN QUEUE
                {
                    [self.tableForQueue insertInto:temp];
                    [self.breadthFirstQueue enqueue:temp];
                }
                else
                {
                    //NSLog(@"IGNORING TABLE SEEN IN QUEUE");
                }
            }
            else
            {
                //NSLog(@"IGNORING TABLE SEEN PREVIOUSLY (U)");
            }
            
        }
        if ([board zeroLocation].x < 2)
        {
            Node *temp = [self generateMove:[board getBoard] array:[board getIteration] depth:[board getZeroLocation] zeroLocation:[board getMoves] moves:@"D"];
            //[self.breadthFirstQueue enqueue:temp];
            
            if (![self.tableForPrevious checkForDuplicate:temp]) //IF OBJECT NOT PREVIOUSLY SEEN
            {
                if (![self.tableForQueue checkForDuplicate:temp]) //IF OBJECT NOT CURRNTLY IN QUEUE
                {
                    [self.tableForQueue insertInto:temp];
                    [self.breadthFirstQueue enqueue:temp];
                }
                else
                {
                    //NSLog(@"IGNORING TABLE SEEN IN QUEUE");
                }
            }
            else
            {
                //NSLog(@"IGNORING TABLE SEEN PREVIOUSLY (D)");
            }
            
        }
        if ([board zeroLocation].y > 0)
        {
            Node *temp = [self generateMove:[board getBoard] array:[board getIteration] depth:[board getZeroLocation] zeroLocation:[board getMoves] moves:@"L"];
            //[self.breadthFirstQueue enqueue:temp];
            
            if (![self.tableForPrevious checkForDuplicate:temp]) //IF OBJECT NOT PREVIOUSLY SEEN
            {
                if (![self.tableForQueue checkForDuplicate:temp]) //IF OBJECT NOT CURRNTLY IN QUEUE
                {
                    [self.tableForQueue insertInto:temp];
                    [self.breadthFirstQueue enqueue:temp];
                }
                else
                {
                    //NSLog(@"IGNORING TABLE SEEN IN QUEUE");
                }
            }
            else
            {
                //NSLog(@"IGNORING TABLE SEEN PREVIOUSLY (L)");
            }
            
        }
        if ([board zeroLocation].y < 2)
        {
            Node *temp = [self generateMove:[board getBoard] array:[board getIteration] depth:[board getZeroLocation] zeroLocation:[board getMoves] moves:@"R"];
            //[self.breadthFirstQueue enqueue:temp];
            
            if (![self.tableForPrevious checkForDuplicate:temp]) //IF OBJECT NOT PREVIOUSLY SEEN
            {
                if (![self.tableForQueue checkForDuplicate:temp]) //IF OBJECT NOT CURRNTLY IN QUEUE
                {
                    [self.tableForQueue insertInto:temp];
                    [self.breadthFirstQueue enqueue:temp];
                }
                else
                {
                    //NSLog(@"IGNORING TABLE SEEN IN QUEUE");
                }
            }
            else
            {
                //NSLog(@"IGNORING TABLE SEEN PREVIOUSLY (R)");
            }
             
        }
    }
    
    NSLog(@"LARGEST # NODES HELD: %d", [self.breadthFirstQueue getMaxSizeSeen]);
    return [board getMoves];
}

-(Node *) generateMove:(NSMutableArray *) a array: (int) i depth: (CGPoint) p zeroLocation: (NSString *) m moves: (NSString *) move
{
    
    NSMutableArray *newArray = [[NSMutableArray alloc] initWithCapacity:3]; //deep copy array
    for (NSMutableArray *row in a)
    {
        NSMutableArray *rowCopy = [NSMutableArray new];
        for (id item in row)
        {
            [rowCopy addObject:[item copy]];
        }
        [newArray addObject: rowCopy];
    }

    //applies move
    if ([move  isEqual: @"U"])
    {
        //NSLog(@"__U__");
        id temp = [[newArray objectAtIndex:(int)p.x - 1] objectAtIndex:(int)p.y];                                       //temporarily store non 0 number;
        [[newArray objectAtIndex:(int)p.x - 1] replaceObjectAtIndex:(int)p.y withObject:[NSNumber numberWithInt:0]];    //put 0 in the non 0 number's location based on direction
        [[newArray objectAtIndex:(int)p.x] replaceObjectAtIndex:(int)p.y withObject:temp];                              //put non 0 number in the old 0 location
        p = CGPointMake( p.x - 1 ,  p.y);                                                                               //update 0 location
    }
    else if ([move  isEqual: @"D"])
    {
        //NSLog(@"__D__");
        id temp = [[newArray objectAtIndex:(int)p.x + 1] objectAtIndex:(int)p.y];
        [[newArray objectAtIndex:(int)p.x + 1] replaceObjectAtIndex:(int)p.y withObject:[NSNumber numberWithInt:0]];
        [[newArray objectAtIndex:(int)p.x] replaceObjectAtIndex:(int)p.y withObject:temp];
        p = CGPointMake( p.x + 1 ,  p.y );
    }
    else if ([move  isEqual: @"L"])
    {
        //NSLog(@"__L__");
        id temp = [[newArray objectAtIndex:(int)p.x] objectAtIndex:(int)p.y - 1];                   ////
        [[newArray objectAtIndex:(int)p.x] replaceObjectAtIndex:(int)p.y - 1 withObject:[NSNumber numberWithInt:0]];
        [[newArray objectAtIndex:(int)p.x] replaceObjectAtIndex:(int)p.y withObject:temp];
        p = CGPointMake( p.x ,  p.y - 1 );
    }
    else
    {
        //NSLog(@"__R__");
        
        id temp = [[newArray objectAtIndex:(int)p.x] objectAtIndex:(int)p.y + 1];                   ////
        [[newArray objectAtIndex:(int)p.x] replaceObjectAtIndex:(int)p.y + 1 withObject:[NSNumber numberWithInt:0]];
        [[newArray objectAtIndex:(int)p.x] replaceObjectAtIndex:(int)p.y withObject:temp];
        p = CGPointMake( p.x ,  p.y + 1 );
    }
    
    Node *newNode = [[Node alloc] initNode: newArray board: (i + 1) depth: [NSString stringWithFormat:@"%@%@", m, move]]; //creates new node with updated board, current depth, and current set of moves

    return newNode;
}

@end
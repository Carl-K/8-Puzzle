//
//  depthFirstSearch.m
//  firstGame
//
//  Created by Carl Kruk on 1/24/15.
//  Copyright (c) 2015 Carl Kruk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "depthFirstSearch.h"

@implementation depthFirstSearch
@synthesize depthFirstStack, correctBoard, tableForStack, tableForPrevious;

-(id) initDepthFirstSearch
{
    self.depthFirstStack = [[stack alloc] initStack];
    self.correctBoard = [[[boardTypes alloc] initBoardTypes] getCorrectArray];
    self.tableForStack = [[hashTable alloc] initHashTable:13];  //hash tables of size 13
    self.tableForPrevious = [[hashTable alloc] initHashTable:13];
    return self;
}

-(NSString *) depthFirst:(Node *)n
{
    [self.depthFirstStack push:n];  //add initial table to stack
    [self.tableForStack insertInto:n]; //add initial table to hash table for stack
    Node *board;
    
    while(![self.depthFirstStack isEmpty])
    {
        board = [self.depthFirstStack pop]; //pop object from stack
        [self.tableForPrevious insertInto:board]; //add object to previously visited hash table
        [self.tableForStack deleteObject:board];  //remove object from hash table for stack
        
        if ([board compareBoards:self.correctBoard]) //check if current state is goal state
        {
            break;
        }
        
        //makes a move for all directions the 0 tile can go in the current state
        if ([board zeroLocation].x > 0) //UP
        {
            Node *temp = [self generateMove:[board getBoard] array:[board getIteration] depth:[board getZeroLocation] zeroLocation:[board getMoves] moves:@"U"]; //GENERATE UP
            //[self.depthFirstStack push:temp];
            
            if (![self.tableForPrevious checkForDuplicate:temp]) //check if object does not currently exist in hash table for previously visited
            {
                if (![self.tableForStack checkForDuplicate:temp]) //check if object does not currently exist in hash table for stack
                {
                    [self.tableForStack insertInto:temp]; //insert object to hash table for stack
                    [self.depthFirstStack push:temp]; //push object onto stack
                }
            }
             
            /* //output that shows that objects will be ignored if it was seen previously or current in the linked list
            else
            {
                NSLog(@"TABLE NOT ADDED (U):");
                for (int i = 0; i < 3; i++)
                {
                    NSMutableArray *row = [[temp getBoard] objectAtIndex:i];
                    NSLog(@"%d %d %d", [[row objectAtIndex:0] intValue], [[row objectAtIndex:1] intValue], [[row objectAtIndex:2] intValue]);
                }
            }
             */
        }
        
        if ([board zeroLocation].x < 2) //DOWN
        {
            Node *temp = [self generateMove:[board getBoard] array:[board getIteration] depth:[board getZeroLocation] zeroLocation:[board getMoves] moves:@"D"]; //GENERATE DOWN
            //[self.depthFirstStack push:temp];
            
            if (![self.tableForPrevious checkForDuplicate:temp]) ////
            {
                if (![self.tableForStack checkForDuplicate:temp]) ////
                {
                    [self.tableForStack insertInto:temp]; ////
                    [self.depthFirstStack push:temp]; ////
                }
            }
             
            /*
            else
            {
                NSLog(@"TABLE NOT ADDED (D):");
                for (int i = 0; i < 3; i++)
                {
                    NSMutableArray *row = [[temp getBoard] objectAtIndex:i];
                    NSLog(@"%d %d %d", [[row objectAtIndex:0] intValue], [[row objectAtIndex:1] intValue], [[row objectAtIndex:2] intValue]);
                }
            }
             */
        }
        
        if ([board zeroLocation].y > 0) //LEFT
        {
            Node *temp = [self generateMove:[board getBoard] array:[board getIteration] depth:[board getZeroLocation] zeroLocation:[board getMoves] moves:@"L"];  //GENERATE LEFT
            //[self.depthFirstStack push:temp];
            
            if (![self.tableForPrevious checkForDuplicate:temp]) ////
            {
                if (![self.tableForStack checkForDuplicate:temp]) ////
                {
                    [self.tableForStack insertInto:temp]; ////
                    [self.depthFirstStack push:temp]; ////
                }
            }
             
             /* //output that shows that objects will be ignored if it was seen previously or current in the linked list
            else
            {
                NSLog(@"TABLE NOT ADDED (L):");
                for (int i = 0; i < 3; i++)
                {
                    NSMutableArray *row = [[temp getBoard] objectAtIndex:i];
                    NSLog(@"%d %d %d", [[row objectAtIndex:0] intValue], [[row objectAtIndex:1] intValue], [[row objectAtIndex:2] intValue]);
                }
            }
              */
        }
        
        if ([board zeroLocation].y < 2) //RIGHT
        {
            Node *temp = [self generateMove:[board getBoard] array:[board getIteration] depth:[board getZeroLocation] zeroLocation:[board getMoves] moves:@"R"];  //GENERATE RIGHT
            //[self.depthFirstStack push:temp];
            
            if (![self.tableForPrevious checkForDuplicate:temp]) ////
            {
                if (![self.tableForStack checkForDuplicate:temp]) ////
                {
                    [self.tableForStack insertInto:temp]; ////
                    [self.depthFirstStack push:temp]; ////
                }
            }
             
             /* //output that shows that objects will be ignored if it was seen previously or current in the linked list
            else
            {
                NSLog(@"TABLE NOT ADDED (R):");
                for (int i = 0; i < 3; i++)
                {
                    NSMutableArray *row = [[temp getBoard] objectAtIndex:i];
                    NSLog(@"%d %d %d", [[row objectAtIndex:0] intValue], [[row objectAtIndex:1] intValue], [[row objectAtIndex:2] intValue]);
                }
            }
              */
        }
         
    }
    
    NSLog(@"LARGEST # NODES HELD: %d", [self.depthFirstStack getMaxSizeSeen]);
    return [board getMoves]; //return moves made by zero tile
}

-(Node *) generateMove:(NSMutableArray *) a array: (int) i depth: (CGPoint) p zeroLocation: (NSString *) m moves: (NSString *) move //basically swaps zero and the direction to swap with each other
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
    
    //applies move to board
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
    
    Node *newNode = [[Node alloc] initNode: newArray board: (i + 1) depth: [NSString stringWithFormat:@"%@%@", m, move]]; //creates new node with updated board, updated depth, and updated set of moves
    
    return newNode; //returns above variable
}

@end
//
//  Node.m
//  firstGame
//
//  Created by Carl Kruk on 1/17/15.
//  Copyright (c) 2015 Carl Kruk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Node.h"

@implementation Node
@synthesize currentBoard, iteration, zeroLocation, moves, mH, FofNfromManhattan, FofNfromMisplaced;

-(id) initNode:(NSMutableArray *) board board:(int) n depth: (NSString *) m
{
    self.currentBoard = board; //store array
    self.iteration = n; //store depth
    for (int i = 0; i < self.currentBoard.count; i++)
    {
        NSMutableArray *row = [self.currentBoard objectAtIndex:i];
        for (int j = 0; j < row.count; j++)
        {
            if ([row objectAtIndex:j] == [NSNumber numberWithInt:0])
            {
                self.zeroLocation = CGPointMake(i, j); //store where zero is located
                //NSLog(@"ZERO FOUND AT %d, %d", i, j);
            }
        }
    }
    self.moves = m; //store moves that the 0 tile makes
    //self.next = [[NSMutableArray alloc] initWithCapacity:4]; //store up to 4 boards
    self.next = NULL;
    
    self.mH = [[manhattanDistance alloc] initManhattanDistance];
    
    self.manhattanDistance = [self computeManhattanDistance]; //used for greedy best
    
    self.FofNfromManhattan = self.manhattanDistance + 1; //used for A*
    self.FofNfromMisplaced = [self computeMisplaced] + 1;
    
    return self;
}

-(BOOL) compareBoards:(NSMutableArray *)otherBoard
{
    for (int i = 0; i < otherBoard.count; i++)
    {
        NSMutableArray *thisRow = [[self getBoard] objectAtIndex:i];
        NSMutableArray *thatRow = [otherBoard objectAtIndex:i];
        for (int j = 0; j < thisRow.count; j++)
        {
            //NSLog(@"IS %@ SAME AS %@?", [thisRow objectAtIndex:j],  [thatRow objectAtIndex:j]);
            if ([thisRow objectAtIndex:j] != [thatRow objectAtIndex:j])
            {
                //NSLog(@"IS %@ SAME AS %@?", [thisRow objectAtIndex:j],  [thatRow objectAtIndex:j]);
                return false;
            }
        }
    }
    NSLog(@"GOAL STATE REACHED");
    return true;
}

-(NSMutableArray *) getBoard //return array
{
    return self.currentBoard;
}

-(int) getIteration //return depth
{
    return self.iteration;
}

-(NSString *) getMoves
{
    return self.moves;
}

-(CGPoint) getZeroLocation
{
    return self.zeroLocation;
}

-(void) printBoardToConsole
{
    for (int i = 0; i < 3; i++)
    {
        NSMutableArray *row = [self.currentBoard objectAtIndex:i];
        for (int j = 0; j < 3; j++)
        {
            NSLog(@"%@ ", [row objectAtIndex:j]);
        }
    }
}

-(int) computeMisplaced
{
    int n = 0;
    for (int i = 0; i < 3; i++)
    {
        NSMutableArray *row = [self.currentBoard objectAtIndex:i];
        for (int j = 0; j < 3; j++)
        {
            n += [self.mH computeMisplacedTiles:CGPointMake(i, j) point:[[row objectAtIndex:j] intValue]];
        }
    }
    return n;
}

-(int) computeManhattanDistance
{
    int n = 0;
    for (int i = 0; i < 3; i++)
    {
        NSMutableArray *row = [self.currentBoard objectAtIndex:i];
        for (int j = 0; j < 3; j++)
        {
            n += [self.mH computeDistance:CGPointMake(i, j) point:[[row objectAtIndex:j] intValue]];
        }
    }
    return n;
}

-(int) getManhattanDistance
{
    return self.manhattanDistance;
}

-(int) getFofNfromManhattan
{
    return self.FofNfromManhattan;
}

-(int) getFofNfromMisplaced
{
    return self.FofNfromMisplaced;
}

@end
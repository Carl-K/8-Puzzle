//
//  Node.h
//  firstGame
//
//  Created by Carl Kruk on 1/17/15.
//  Copyright (c) 2015 Carl Kruk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "manhattanDistance.h"

@interface Node : NSObject

//-----OBJECT TO STORE CURRENT GOAL STATE, DEPTH, AND MOVES DONE TO REACH IT FROM INITIAL STATE

-(id) initNode:(NSMutableArray *) board board:(int) n depth: (NSString *) m; //init method/constructor

-(NSMutableArray *) getBoard; //return array
-(int) getIteration; //return depth
-(NSString *) getMoves; //return moves made by the zero tile
-(CGPoint) getZeroLocation; //return location of the 0 tile in the array
-(BOOL) compareBoards:(NSMutableArray *) otherBoard; //check if current board is the goal state

-(int) computeManhattanDistance;
-(int) getManhattanDistance;

-(int) getFofNfromManhattan;
-(int) getFofNfromMisplaced;

-(void) printBoardToConsole;

@property NSMutableArray *currentBoard; //store array
@property int iteration; //store depth
//@property NSMutableArray *next; //store up to the next 4 boards
@property Node *next;
@property CGPoint zeroLocation; //store where the zero tile is located
@property NSString *moves; //store the moves the zero tile makes

@property manhattanDistance *mH;
@property int manhattanDistance;

@property int FofNfromManhattan; //HEURISTIC VALUES FOR A*2
@property int FofNfromMisplaced; //A*1

@end
